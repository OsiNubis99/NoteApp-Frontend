

import 'package:flutter/material.dart';
import 'package:note_app_frontend/config/helpers/get_notes.dart';

import '../../../domain/entities/note.dart';



class NoteProvider extends ChangeNotifier{

  final GetNotes getNotesAnswer = GetNotes();



  List<Note> notes = [];


Future<void> getNotes() async{
  final notesAnswer = await getNotesAnswer.getAnswer();
  notes = [];
  notes.addAll(notesAnswer);
  notifyListeners();
}

}

