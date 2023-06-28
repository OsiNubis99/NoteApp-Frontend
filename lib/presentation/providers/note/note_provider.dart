import 'package:flutter/material.dart';
import 'package:note_app_frontend/config/helpers/create_note.dart';
import 'package:note_app_frontend/config/helpers/get_notes.dart';

import '../../../domain/entities/note.dart';

class NoteProvider extends ChangeNotifier {
  final GetNotes getNotesAnswer = GetNotes();
  final CreateNote createNote = CreateNote();

  List<NoteEntity> notes = [];

  Future<void> getNotes() async {
    final notesAnswer = await getNotesAnswer.getAnswer();
    notes = [];
    notes.addAll(notesAnswer);
    notifyListeners();
  }

  Future<bool> addNote({
    required String title,
    String description = '',
  }) async {
    final response = await createNote.createNote(
      description: description,
      title: title,
    );
    notifyListeners();
    return response;
  }
}
