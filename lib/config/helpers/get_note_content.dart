import 'package:dio/dio.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';

class GetNoteContent {
  static final _dio = Dio();

  static Future<Note> execute(String idNote) async {
    final response = await _dio
        .get('https://noteapp-backend-prod.up.railway.app/note/$idNote');

    return Note.fromJson(response.data);
  }
}
