import 'package:flutter/material.dart';
import 'package:note_app_frontend/config/helpers/create_note.dart';
import 'package:note_app_frontend/config/helpers/get_notes.dart';
import 'package:note_app_frontend/config/helpers/update_note.dart';

import '../../../domain/entities/note.dart';

class NoteProvider extends ChangeNotifier {
  final GetNotes getNotesAnswer = GetNotes();
  final CreateNoteService createNote = CreateNoteService();
  final UpdateNote updateNoteService = UpdateNote();

  List<NoteEntity> notes = [];
  List<NoteEntity> notesInactive = [];

  Future<void> getNotes() async {
    final notesAnswer = await getNotesAnswer.getAnswer();
    notes = [];
    notes.addAll(notesAnswer);
    notes = List.from(notes.reversed);

    notesInactive = notes.where((note) => note.estadoNota == 'Inactive').toList();
    notes = notes.where((note) => note.estadoNota == 'Active').toList();

    notifyListeners();
  }

  Future<dynamic> addNote({
    required String title,
    String description = '',
  }) async {
    final response = await createNote.execute(
      description: description,
      title: title,
    );
    notifyListeners();
    return response;
  }

  Future<dynamic> updateNote(NoteEntity note) async {
    final response = await updateNoteService.execute(note: note);
    notifyListeners();
    return response;
  }
}
