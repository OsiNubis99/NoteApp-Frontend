import 'package:dio/dio.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';

import '../../domain/entities/note.dart';

class GetNotes {

final _dio = Dio();

Future<List<NoteEntity>> getAnswer() async {
  
  final List<NotesByUserId> notesByUser = [];
  List<NoteEntity> notes = [];

  final response = await _dio.get('https://mynoteapp-prod.up.railway.app/user/1/notes');
  
  print(response.data[0]['notes']);

  for(final item in response.data[0]['notes']){
      NoteEntity noteIn = NoteEntity(
        idNota:          item['idNota'], 
        cuerpoNotaText:  item['cuerpoNotaText'], 
        cuerpoNotaImg:   item['cuerpoNotaImg'], 
        estadoNota:      item['estadoNota'], 
        etiquetaNota:    item['etiquetaNota'], 
        fechaNota:       item['fechaNota'], 
        tituloNota:      item['tituloNota']);

      notes.add(noteIn);
  }


  return notes;

}

}