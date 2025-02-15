import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:note_app_frontend/config/helpers/get_notes.dart';
import 'package:note_app_frontend/config/helpers/sync_helper.dart';
import 'package:note_app_frontend/infrastructure/enumns/offline_status.dart';
import 'package:note_app_frontend/infrastructure/models/body_model.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';
import 'package:note_app_frontend/infrastructure/models/task_model.dart';
import 'package:uuid/uuid.dart';

import '../user_provider.dart';

class LocalNoteProvider extends ChangeNotifier {
  // Utils
  final _uuid = const Uuid();
  static final _userProvider = UserProvider();

  final _box = Hive.box<Note>('notesOf_${_userProvider.getId()}');

  // Notes list
  List<Note> localNotes = [];

  // Get Notes List
  void getNotes() async {
    localNotes = _box.values.where((note) => note.status == 'active').toList();
     localNotes = List.from(localNotes.reversed);
  }

  // Get Note By id
  Note? getNoteById(String noteId) {
    return _box.get(noteId);
  }

  // Get notes unsync
  List<Note> getNoteUnSync() {
    return _box.values
        .where((note) =>
            note.offlineStatus != OfflineStatus.ok ||
            note.tasks
                .any((element) => element.offlineStatus != OfflineStatus.ok) ||
            note.body
                .any((element) => element.offlineStatus != OfflineStatus.ok))
        .toList();
  }

  List<Note> getNotesInactive() {
    return _box.values.where((note) => note.status != 'active').toList();
  }

  // Get Notes from server
  void getNotesServer() async {
    getNotes();
    final notesServer = await GetNotes.execute();
    for (var note in notesServer) {
      note.offlineStatus = OfflineStatus.ok;
      var localNote = _box.get(note.id);
      if (localNote == null) {
        await _box.put(note.id, note);
      } else {
        if (localNote.offlineStatus == OfflineStatus.ok) {
          localNote.title = note.title;
          localNote.description = note.description;
        }
        for (var body in note.body) {
          var index =
              localNote.body.indexWhere((element) => element.id == body.id);
          if (index < 0) {
            localNote.body.add(body);
          } else {
            if (localNote.body[index].offlineStatus == OfflineStatus.ok) {
              localNote.body[index] = body;
            }
          }
        }
        for (var task in note.tasks) {
          var index =
              localNote.tasks.indexWhere((element) => element.id == task.id);
          if (index < 0) {
            localNote.tasks.add(task);
          } else {
            if (localNote.tasks[index].offlineStatus == OfflineStatus.ok) {
              localNote.tasks[index] = task;
            }
          }
        }
        localNote.save();
      }
    }
  }

  // Create Note
  void addNote(Note newNote) async {
    await _box.put(newNote.id, newNote);
  }

  // Create Note Body
  void addNoteBody(String noteId, Body newBody) async {
    newBody.offlineStatus = OfflineStatus.created;
    final note = _box.get(noteId);
    if (note != null) {
      newBody.id = "local_${_uuid.v4()}";
      note.body.add(newBody);
      await note.save();
      if (!noteId.startsWith('offline_')) {
        await SyncHelper.execute();
      }
    }
  }

  // Create Note Task
  void addNoteTask(String noteId, Task newTask) async {
    newTask.offlineStatus = OfflineStatus.created;
    final note = _box.get(noteId);
    if (note != null) {
      newTask.id = _uuid.v4();
      note.tasks.add(newTask);
      await note.save();
      if (!noteId.startsWith('offline_')) {
        await SyncHelper.execute();
      }
    }
  }

  // Read Note
  Note getNote(String id) {
    getNotes();
    return localNotes.firstWhere((element) => element.id == id);
  }

  // Update Note
  void editNote(Note note, String noteKey) async {
    _box.put(noteKey, note);
    await SyncHelper.execute();
  }

  // Update Note
  void saveNote(Note note, String noteKey) async {
    if (noteKey.startsWith('offline_')) {
      _box.delete(noteKey);
      noteKey = note.id;
    }
    _box.put(noteKey, note);
  }

  // Update Note Body
  void editNoteBody(String noteId, Body editedBody) async {
    editedBody.offlineStatus = OfflineStatus.edited;
    final note = _box.get(noteId);
    if (note != null) {
      for (var bdy in note.body) {
        if (bdy.id == editedBody.id) {
          bdy = editedBody;
        }
      }
      await note.save();
      if (!noteId.startsWith('offline_')) {
        await SyncHelper.execute();
      }
    }
  }

  // Update Note Task
  void editNoteTask(String noteId, Task editedTask) async {
    editedTask.offlineStatus = OfflineStatus.edited;
    final note = _box.get(noteId);
    if (note != null) {
      for (var tsk in note.tasks) {
        if (tsk.id == editedTask.id) {
          tsk = editedTask;
        }
      }
      await note.save();
      if (!noteId.startsWith('offline_')) {
        await SyncHelper.execute();
      }
    }
  }

  // Delete Note
  void deleteNote(int index) async {
    await _box.deleteAt(index);
  }

  // Delete Note Body
  void deleteNoteBody(String noteId, int index) async {
    final note = _box.get(noteId);
    if (note != null && index >= 0 && index < note.body.length) {
      note.body.removeAt(index);
      await note.save();
    }
  }

  // Delete Note Task
  void deleteNoteTask(String noteId, int index) async {
    final note = _box.get(noteId);
    if (note != null && index >= 0 && index < note.tasks.length) {
      note.tasks.removeAt(index);
      await note.save();
    }
  }
}
