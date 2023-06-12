import '../entities/note.dart';

abstract class NoteRepository {

  Future<List<Note>> getAllNoteByUser(String userID);

}