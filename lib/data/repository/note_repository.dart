import 'package:jars_mobile/data/models/note.dart';

abstract class NoteRepository {
  Future<Note> getNote({required String idToken, required int noteId});
}
