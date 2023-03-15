import 'package:flutter/foundation.dart';
import 'package:jars_mobile/data/models/note.dart';
import 'package:jars_mobile/data/remote/response/api_response.dart';
import 'package:jars_mobile/data/repository/note_repository_impl.dart';

class NoteViewModel extends ChangeNotifier {
  final _noteRepo = NoteRepositoryImpl();
  ApiResponse<List> notes = ApiResponse.loading();
  void _setNote(ApiResponse<List> response) {
    notes = response;
    notifyListeners();
  }

  Future<Note> getNote({required String idToken, required int noteId}) async {
    return await _noteRepo.getNote(idToken: idToken, noteId: noteId);
  }

  Future<Note> createNote({
    required String idToken,
    required String addDate,
    String? comments,
    String? image,
    required num contractId,
    num? latitude,
    num? longitude,
  }) async {
    return await _noteRepo
        .addNote(
          contractId: contractId,
          idToken: idToken,
          addDate: addDate,
          comments: comments,
          latitude: latitude,
          image: image,
          longitude: longitude,
        )
        .then((value) => value)
        .whenComplete(() => _setNote(ApiResponse.completed(null)))
        .catchError((error, stackTrace) => _setNote(ApiResponse.error(error.toString())));
  }
}
