import 'package:dio/dio.dart';
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
      print(note.toCreateJson());
      print(note.offlineStatus);
      if (note.offlineStatus == OfflineStatus.created) {
        await _dio
            .post('https://noteapp-backend-prod.up.railway.app/note',
                data: note.toCreateJson())
            .then((value) {
          print(value);
          note.offlineStatus = OfflineStatus.ok;
        });
      } else {
        if (note.offlineStatus == OfflineStatus.edited) {
          await _dio
              .put(
                  'https://noteapp-backend-prod.up.railway.app/note/${note.id}',
                  data: note.toUpdateJson())
              .then((value) => note.offlineStatus = OfflineStatus.ok);
        }
        for (var i = 0; i < note.body.length; i++) {
          if (note.body[i].offlineStatus == OfflineStatus.created ||
              note.body[i].id.startsWith('offline_')) {
            await _dio
                .post(
                    'https://noteapp-backend-prod.up.railway.app/body/${note.id}',
                    data: note.body[i].toCreateJson())
                .then((value) => note.body[i].offlineStatus = OfflineStatus.ok);
          }
          if (note.body[i].offlineStatus == OfflineStatus.edited) {
            await _dio
                .put(
                    'https://noteapp-backend-prod.up.railway.app/body/${note.body[i].id}',
                    data: note.body[i].toUpdateJson())
                .then((value) => note.body[i].offlineStatus = OfflineStatus.ok);
          }
        }
        for (var i = 0; i < note.tasks.length; i++) {
          if (note.tasks[i].offlineStatus == OfflineStatus.created ||
              note.tasks[i].id.startsWith('offline_')) {
            await _dio
                .post(
                    'https://noteapp-backend-prod.up.railway.app/task/${note.id}',
                    data: note.tasks[i].toCreateJson())
                .then(
                    (value) => note.tasks[i].offlineStatus = OfflineStatus.ok);
          }
          if (note.tasks[i].offlineStatus == OfflineStatus.edited) {
            await _dio
                .put(
                    'https://noteapp-backend-prod.up.railway.app/task/${note.tasks[i].id}',
                    data: note.tasks[i].toUpdateJson())
                .then(
                    (value) => note.tasks[i].offlineStatus = OfflineStatus.ok);
          }
        }
        _noteProvider.saveNote(note, note.id);
      }
    }
  }
}
