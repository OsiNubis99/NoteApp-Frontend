import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:note_app_frontend/config/helpers/get_notes.dart';
import 'package:note_app_frontend/domain/entities/body.dart';
import 'package:note_app_frontend/domain/entities/task.dart';
import 'package:note_app_frontend/infrastructure/enumns/offline_status.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';

class LocalNoteProvider extends ChangeNotifier {
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

  // Get Notes from server
  void getNotesServer() async {
    getNotes();
    final notesServer = await GetNotes.execute();
    // Logica para que guarde las notas que no existan en el box
    for (var note in notesServer) {
      if (!localNotes.any((element) => element.id == note.id)) {
        _box.add(note);
      }
    }
  }

  // Create Note
  void addNote(Note newNote) async {
    await _box.add(newNote);
  }

  // Create Note Body
  void addNoteBody(String noteId, BodyEntity newBody) async {
    final note = _box.get(noteId);
    if (note != null) {
      newBody.offlineStatus = OfflineStatus.created;
      note.body.add(newBody);
      await note.save();
    }
  }

  // Create Note Task
  void addNoteTask(String noteId, TaskEntity newTask) async {
    final note = _box.get(noteId);
    if (note != null) {
      newTask.offlineStatus = OfflineStatus.created;
      note.tasks.add(newTask);
      await note.save();
    }
  }

  // Read Note
  Note getNote(index) {
    getNotes();
    return localNotes[index];
  }

  // Update Note
  void editNote(Note note, int noteKey) async {
    await _box.put(noteKey, note);
  }

  // Update Note Body
  void editNoteBody(String noteId, int index, BodyEntity editedBody) async {
    final note = _box.get(noteId);
    if (note != null && index >= 0 && index < note.body.length) {
      editedBody.offlineStatus = OfflineStatus.edited;
      note.body[index] = editedBody;
      await note.save();
    }
  }

  // Update Note Task
  void editNoteTask(String noteId, int index, TaskEntity editedTask) async {
    final note = _box.get(noteId);
    if (note != null && index >= 0 && index < note.tasks.length) {
      editedTask.offlineStatus = OfflineStatus.edited;
      note.tasks[index] = editedTask;
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
