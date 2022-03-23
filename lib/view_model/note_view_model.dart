import 'package:jars_mobile/data/models/note.dart';
import 'package:jars_mobile/data/repository/note_repository_impl.dart';

class NoteViewModel {
  final _noteRepo = NoteRepositoryImpl();

  Future<Note> getNote({required String idToken, required int noteId}) async {
    return await _noteRepo.getNote(idToken: idToken, noteId: noteId);
  }
}
