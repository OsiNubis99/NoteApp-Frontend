import '../entities/note.dart';

abstract class NoteDatasource {

  Future<List<NoteEntity>> getAllNoteByUser(String userID);

}