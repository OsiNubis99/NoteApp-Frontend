

import 'package:flutter/material.dart';

import '../../../domain/entities/note.dart';

class NoteProvider extends ChangeNotifier{

  List<Note> notes = [
    Note(title:'Primera nota 1', body: 'Texto descriptivo de la nota como para rellenar , tu sabes'),
    Note(title:'Primera nota 2', body: 'Texto descriptivo de la nota como para rellenar , tu sabes'),
  ];



Future<void> addNote() async {
  // TODO
}

}

