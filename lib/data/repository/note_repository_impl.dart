import 'dart:convert';

import 'package:jars_mobile/data/models/note.dart';
import 'package:jars_mobile/data/remote/network/api_end_point.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';
import 'package:jars_mobile/data/remote/network/network_api_service.dart';
import 'package:jars_mobile/data/repository/interface/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<Note> getNote({required String idToken, required int noteId}) async {
    try {
      dynamic response = await _apiService.getResponse(
        '${ApiEndPoint().note}/$noteId',
        header: Map<String, String>.from({
          "Authorization": "Bearer $idToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
      );
      return Note.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future addNote({
    required String idToken,
    required String addDate,
    String? comments,
    String? image,
    required num contractId,
    num? latitude,
    num? longitude,
  }) async {
    dynamic response = await _apiService.postResponse(
      ApiEndPoint().note + '?contract_id=' + contractId.toString(),
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Accept": "application/json",
        "Content-Type": "application/json",
      }),
      body: jsonEncode(Map<String, dynamic>.from({
        "addedDate": addDate,
        "comments": comments,
        "image": image,
        "contractId": contractId,
        "latitude": latitude,
        "longitude": longitude,
      })),
    );
    return Note.fromJson(response);
  }
}
