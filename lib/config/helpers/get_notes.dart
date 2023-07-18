import 'package:dio/dio.dart';
import 'package:note_app_frontend/config/helpers/get_note_content.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';
import 'package:note_app_frontend/infrastructure/models/user_data.dart';

class GetNotes {
  static final _dio = Dio();

  static Future<List<Note>> execute() async {
    List<Note> notes = [];

    final response = await _dio.get(
        'https://noteapp-backend-prod.up.railway.app/user/${UserData.id}/notes');

    for (final item in response.data['notes']) {
      notes.add(await GetNoteContent.execute(item['idNota']));
    }

    return notes;
  }
}
