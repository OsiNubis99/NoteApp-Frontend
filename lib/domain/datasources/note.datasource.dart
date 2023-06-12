import '../entities/note.dart';

abstract class NoteDatasource {

  Future<List<Note>> getAllNoteByUser(String userID);

}