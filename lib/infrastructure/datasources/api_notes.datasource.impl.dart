import 'package:note_app_frontend/domain/datasources/note.datasource.dart';
import 'package:note_app_frontend/domain/entities/note.dart';

class ApiNoteDatasource implements NoteDatasource{
  @override
  Future<List<Note>> getAllNoteByUser(String userID) {
    
    
    // TODO: implementar coinexión con API


    throw UnimplementedError();
  }

}