import 'package:dio/dio.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';

import '../../domain/entities/note.dart';

class GetNotes {
  final _dio = Dio();

  Future<List<NoteEntity>> getAnswer() async {
    final List<NotesByUserId> notesByUser = [];
    List<NoteEntity> notes = [];

    final response =
        await _dio.get('https://mynoteapp-dev.up.railway.app/user/1/notes');

    print(response.data['notes'][0]);

    for (final item in response.data['notes']) {
      NoteEntity noteIn = NoteEntity(
          idNota: item['idNota'],
          descriptionNota: item['descripcionNota'],
          estadoNota: item['estadoNota'],
          fechaNota: item['fechaNota'],
          tituloNota: item['tituloNota']);

      notes.add(noteIn);
    }

    return notes;
  }
}
