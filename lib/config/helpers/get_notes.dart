import 'package:dio/dio.dart';

import '../../domain/entities/note.dart';

class GetNotes {
  final _dio = Dio();

  Future<List<NoteEntity>> getAnswer() async {
    List<NoteEntity> notes = [];

    final response =
        await _dio.get('https://noteapp-backend-prod.up.railway.app/user/1/notes');

    for (final item in response.data['notes']) {
      NoteEntity noteIn = NoteEntity(
          idNota: item['idNota'],
          descriptionNota: item['descripcionNota'],
          estadoNota: item['estadoNota'],
          fechaNota: item['fechaNota'],
          tituloNota: item['tituloNota'],
          descripcionGPS: item['descripcionGPS'],
          latitud: item['latitud'],
          longitud: item['longitud']);
      notes.add(noteIn);
    }

    return notes;
  }
}
