

import 'package:flutter/material.dart';
import 'package:note_app_frontend/config/helpers/get_notes.dart';

import '../../../domain/entities/note.dart';



class NoteProvider extends ChangeNotifier{

  final GetNotes getNotesAnswer = GetNotes();



  List<Note> notes = [
    Note(title:'Primera nota 1', body: 'Texto descriptivo de la nota como para rellenar , tu sabes'),
    Note(title:'Primera nota 2', body: 'Texto descriptivo de la nota como para rellenar , tu sabes'),
  ];


Future<void> getNotes() async{
  final notesAnswer = await getNotesAnswer.getAnswer();
  notes.addAll(notesAnswer);
  notifyListeners();
}


Future<void> addNote() async {
  // TODO
  await getNotes();
  print(notes[3].body);
  notifyListeners();
}

}

