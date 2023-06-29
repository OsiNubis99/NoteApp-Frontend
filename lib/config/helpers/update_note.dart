import 'package:dio/dio.dart';
import 'package:note_app_frontend/domain/entities/note.dart';

class UpdateNote {
  final _dio = Dio();

  Future<dynamic> execute({
    required NoteEntity note,
  }) async {
    final response =
        await _dio.put('https://mynoteapp-dev.up.railway.app/note/${note.idNota}', data: {
      "desc": note.descriptionNota,
      "titulo": note.tituloNota,
      "fechaC": note.fechaNota,
      "est": note.estadoNota,
    });
    return response.data;
  }
}
