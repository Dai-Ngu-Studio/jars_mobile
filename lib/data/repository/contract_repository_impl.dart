import 'dart:convert';

import 'package:jars_mobile/data/models/bill.dart';
import 'package:jars_mobile/data/models/contract.dart';
import 'package:jars_mobile/data/remote/network/api_end_point.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';
import 'package:jars_mobile/data/remote/network/network_api_service.dart';
import 'package:jars_mobile/data/repository/interface/contract_repository.dart';

class ContractRepositoryImpl extends ContractRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<Bill> getBill({required String idToken, required int billId}) async {
    try {
      dynamic response = await _apiService.getResponse(
        '${ApiEndPoint().bill}/$billId',
        header: Map<String, String>.from({
          "Authorization": "Bearer $idToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
      );
      return Bill.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future addContract({required token, required Contract contract}) async {
    try {
      dynamic response = await _apiService.postResponse(
        ApiEndPoint().contract,
        header: Map<String, String>.from({
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
        body: jsonEncode(
          Map<String, dynamic>.from({
            "accountId": contract.accountId,
            "scheduleTypeId": contract.scheduleTypeId,
            "startDate": contract.startDate,
            "endDate": contract.endDate,
            "amount": contract.amount.toString(),
            "name": contract.name,
            "note": contract.note,
          }),
        ),
      );
      return response;
    } on FormatException catch (_) {}
  }

  @override
  Future getContracts({required token, num? page, num? size}) async {
    try {
      dynamic response = await _apiService.getResponse(
        page != null && size != null
            ? ApiEndPoint().contract + '?page=' + page.toString() + '&size=' + size.toString()
            : ApiEndPoint().contract,
        header: Map<String, String>.from({
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
      );
      final json = [];

      for (var item in response) {
        json.add(Contract.fromJson(item));
      }
      return json;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Contract> getContract({required String idToken, required int contractId}) async {
    dynamic response = await _apiService.getResponse(
      '${ApiEndPoint().contract}/$contractId',
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Accept": "application/json",
        "Content-Type": "application/json",
      }),
    );
    return Contract.fromJson(response);
  }

  @override
  Future updateContract({
    required String idToken,
    required int contractId,
    required int noteId,
    required String name,
    required String startDate,
    required String endDate,
    required num scheduleTypeId,
    required num amount,
    required String accountId,
    required String comment,
    double? longitude,
    double? latitude,
    String? image,
    String? addedDate,
  }) async {
    await _apiService.putResponse(
      '${ApiEndPoint().contract}/$contractId',
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Accept": "application/json",
        "Content-Type": "application/json",
      }),
      body: jsonEncode(
        Map<String, dynamic>.from({
          "id": contractId,
          "accountId": accountId,
          "scheduleTypeId": scheduleTypeId,
          "noteId": noteId,
          "startDate": startDate,
          "endDate": endDate,
          "amount": amount,
          "name": name,
          "note": {
            "id": noteId,
            "addedDate": addedDate,
            "comments": comment,
            "image": image,
            "contractId": contractId,
            "latitude": latitude,
            "longitude": longitude
          }
        }),
      ),
    );
  }
}
