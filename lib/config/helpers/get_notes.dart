import 'package:dio/dio.dart';

import '../../domain/entities/note.dart';

class GetNotes {

final _dio = Dio();

Future<List<Note>> getAnswer() async {
  
  final List<Note> notes = [];

  final response = await _dio.get('https://mynoteapp-production.up.railway.app/notes');
  
  for (final item in response.data){
    final noteIn = Note(title: item['Titulo'], body: item['Cuerpo']);
    notes.add(noteIn);
  }

  return notes;

}

}