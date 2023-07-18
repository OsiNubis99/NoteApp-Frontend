import 'package:dio/dio.dart';
import 'package:note_app_frontend/config/helpers/get_note_content.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';
import 'package:note_app_frontend/presentation/providers/note/local_note_provider.dart';

class ThinkHelper {
  static final _dio = Dio();

  static Future<void> execute() async {
    final _noteProvider = LocalNoteProvider();
    //  Para traer todas las notas
    _noteProvider.getNotes();
    //Se almacenan en _noteProvider.localNotes
    _noteProvider.localNotes;

    final response = await _dio
        .get('https://noteapp-backend-prod.up.railway.app/user/1/notes');
  }
}
