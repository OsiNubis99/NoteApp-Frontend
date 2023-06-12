

import 'package:note_app_frontend/domain/datasources/note.datasource.dart';
import 'package:note_app_frontend/domain/entities/note.dart';

class LocalNoteDataSource implements NoteDatasource{
  @override
  Future<List<Note>> getAllNoteByUser(String userID) async {
    
    
    // TODO : Implenmentar notas locales


    throw UnimplementedError();
  }


}