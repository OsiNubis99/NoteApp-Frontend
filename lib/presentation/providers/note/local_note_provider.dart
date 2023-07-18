import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:note_app_frontend/config/helpers/get_notes.dart';
import 'package:note_app_frontend/infrastructure/enumns/offline_status.dart';
import 'package:note_app_frontend/infrastructure/models/body_model.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';
import 'package:note_app_frontend/infrastructure/models/task_model.dart';
import 'package:uuid/uuid.dart';

class LocalNoteProvider extends ChangeNotifier {
  // Utils
  final _uuid = const Uuid();

  // Box name
  static String boxName = 'notes';

  // Notes list
  List<Note> localNotes = [];

  // Use Box
  final _box = Hive.box<Note>(boxName);

  // Get Notes List
  void getNotes() async {
    localNotes = _box.values.toList();
  }

  // Get Note By id
  Note? getNoteById(String noteId) {
    return _box.get(noteId);
  }

  // Get Note By id
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

  // Get Notes from server
  void getNotesServer() async {
    getNotes();
    final notesServer = await GetNotes.execute();
    for (var note in notesServer) {
      if (!localNotes.any((element) => element.id == note.id)) {
        _box.add(note);
      }
    }
  }

  // Create Note
  void addNote(Note newNote) async {
    await _box.put(newNote.id, newNote);
  }

  // Create Note Body
  void addNoteBody(String noteId, Body newBody) async {
    final note = _box.get(noteId);
    if (note != null) {
      newBody.offlineStatus = OfflineStatus.created;
      newBody.id = "local_${_uuid.v4()}";
      note.body.add(newBody);
      await note.save();
    }
  }

  // Create Note Task
  void addNoteTask(String noteId, Task newTask) async {
    final note = _box.get(noteId);
    if (note != null) {
      newTask.offlineStatus = OfflineStatus.created;
      newTask.id = _uuid.v1();
      note.tasks.add(newTask);
      await note.save();
    }
  }

  // Read Note
  Note getNote(String id) {
    getNotes();
    return localNotes.firstWhere((element) => element.id == id);
  }

  // Update Note
  void editNote(Note note, String noteKey) async {
    await _box.put(noteKey, note);
  }

  // Update Note Body
  void editNoteBody(String noteId, Body editedBody) async {
    final note = _box.get(noteId);
    if (note != null) {
      editedBody.offlineStatus = OfflineStatus.edited;
      for (var bdy in note.body) {
        if (bdy.id == editedBody.id) {
          bdy = editedBody;
        }
      }
      await note.save();
    }
  }

  // Update Note Task
  void editNoteTask(String noteId, Task editedTask) async {
    final note = _box.get(noteId);
    if (note != null) {
      editedTask.offlineStatus = OfflineStatus.edited;
      for (var tsk in note.tasks) {
        if (tsk.id == editedTask.id) {
          tsk = editedTask;
        }
      }
      await note.save();
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
