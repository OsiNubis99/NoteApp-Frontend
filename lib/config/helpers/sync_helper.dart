import 'package:dio/dio.dart';
import 'package:note_app_frontend/config/helpers/get_note_content.dart';
import 'package:note_app_frontend/infrastructure/enumns/offline_status.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';
import 'package:note_app_frontend/presentation/providers/note/local_note_provider.dart';

class SyncHelper {
  static final _dio = Dio();

  static Future<void> execute() async {
    final _noteProvider = LocalNoteProvider();
    //  Para traer todas las notas
    List<Note> unSyncNotes = _noteProvider.getNoteUnSync();

    for (final note in unSyncNotes) {
      if (note.offlineStatus == OfflineStatus.created) {
        // todo decidir si ocr o si bat
      } else {
        if (note.offlineStatus == OfflineStatus.edited) {
          await _dio.put('https://noteapp-backend-prod.up.railway.app/note/',
              data: note.toUpdateJson());
        }
        for (final body in note.body) {
          if (body.offlineStatus == OfflineStatus.created) {
            await _dio.put('https://noteapp-backend-prod.up.railway.app/body/',
                data: body.toUpdateJson());
          }
          if (body.offlineStatus == OfflineStatus.edited) {
            await _dio.put('https://noteapp-backend-prod.up.railway.app/body/',
                data: body.toUpdateJson());
          }
        }
        for (final task in note.tasks) {
          if (task.offlineStatus == OfflineStatus.created) {
            await _dio.put('https://noteapp-backend-prod.up.railway.app/task/',
                data: task.toUpdateJson());
          }
          if (task.offlineStatus == OfflineStatus.edited) {
            await _dio.put('https://noteapp-backend-prod.up.railway.app/task/',
                data: task.toUpdateJson());
          }
        }
      }
    }
  }
}
