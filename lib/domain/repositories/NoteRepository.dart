import '../entities/note.dart';

abstract class NoteRepository {

  Future<List<NoteEntity>> getAllNoteByUser(String userID);

}