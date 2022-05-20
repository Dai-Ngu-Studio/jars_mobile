import 'dart:convert';

import 'package:jars_mobile/data/models/bill.dart';
import 'package:jars_mobile/data/remote/network/api_end_point.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';
import 'package:jars_mobile/data/remote/network/network_api_service.dart';
import 'package:jars_mobile/data/repository/bill_repository.dart';

class BillRepositoryImpl extends BillRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<Bill> createBill({
    required String idToken,
    required String name,
    required String date,
    required List<dynamic> billDetails,
  }) async {
    dynamic response = await _apiService.postResponse(
      ApiEndPoint().bill,
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Accept": "application/json",
        "Content-Type": "application/json",
      }),
      body: jsonEncode(Map<String, dynamic>.from({
        "name": name,
        "date": date,
        "billDetails": billDetails,
      })),
    );
    return Bill.fromJson(response);
  }

  @override
  Future<Bill> getBill({
    required String idToken,
    required int billId,
  }) async {
    dynamic response = await _apiService.getResponse(
      '${ApiEndPoint().bill}/$billId',
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Accept": "application/json",
        "Content-Type": "application/json",
      }),
    );
    return Bill.fromJson(response);
  }

  @override
  Future getBills({
    required String idToken,
    required int page,
  }) async {
    dynamic response = await _apiService.getResponse(
      '${ApiEndPoint().bill}?size=8&page=$page&sortOrder=desc',
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Accept": "application/json",
        "Content-Type": "application/json",
      }),
    );

    final json = [];

    for (var item in response) {
      json.add(Bill.fromJson(item));
    }
    return json;
  }

  @override
  Future updateBill({
    required String idToken,
    required int billId,
    required int walletId,
    required String? name,
    required String? date,
    required num leftAmount,
  }) async {
    await _apiService.putResponse(
      '${ApiEndPoint().bill}?bill_id=$billId&wallet_id=$walletId',
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Accept": "application/json",
        "Content-Type": "application/json",
      }),
      body: jsonEncode(
        Map<String, dynamic>.from(
          {
            "name": name,
            "date": date,
            "leftAmount": leftAmount,
          },
        ),
      ),
    );
  }
}
