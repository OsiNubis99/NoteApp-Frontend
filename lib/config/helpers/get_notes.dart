import 'package:dio/dio.dart';
import 'package:note_app_frontend/config/helpers/get_note_content.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';

import '../../presentation/providers/user_provider.dart';

class GetNotes {
  static final _dio = Dio();
  static final _userProvider = UserProvider();

  static Future<List<Note>> execute() async {
    List<Note> notes = [];

    final response = await _dio.get(
        'https://noteapp-backend-prod.up.railway.app/user/${_userProvider.getId()}/notes');

    for (final item in response.data['notes']) {
      notes.add(await GetNoteContent.execute(item['idNota']));
    }

    return notes;
  }
}
