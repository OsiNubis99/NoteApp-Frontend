import 'package:dio/dio.dart';
import 'package:note_app_frontend/config/helpers/get_note_content.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';

class GetNotes {
  static final _dio = Dio();

  static Future<List<Note>> execute() async {
    List<Note> notes = [];

    final response = await _dio
        .get('https://noteapp-backend-prod.up.railway.app/user/1/notes');

    for (final item in response.data['notes']) {
      notes.add(await GetNoteContent.execute(item['idNote']));
    }

    return notes;
  }
}
