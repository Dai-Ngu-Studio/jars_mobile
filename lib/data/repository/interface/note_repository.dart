import 'package:jars_mobile/data/models/note.dart';

abstract class NoteRepository {
  Future<Note> getNote({required String idToken, required int noteId});

  Future addNote({
    required String idToken,
    required String addDate,
    String? comments,
    String? image,
    required num contractId,
    num? latitude,
    num? longitude,
  });
}
