import 'dart:convert';

import 'package:jars_mobile/data/models/transaction.dart';
import 'package:jars_mobile/data/remote/network/api_end_point.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';
import 'package:jars_mobile/data/remote/network/network_api_service.dart';
import 'package:jars_mobile/data/repository/interface/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future addIncome({
    required String idToken,
    required num amount,
    String? noteComment,
    String? noteImage,
  }) async {
    try {
      dynamic response = await _apiService.postResponse(
        ApiEndPoint().transaction,
        function: 'income',
        header: Map<String, String>.from({
          "Authorization": "Bearer $idToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
        body: jsonEncode(
          Map<String, dynamic>.from({
            "amount": amount,
            "noteComment": noteComment,
            "noteImage": noteImage,
          }),
        ),
      );
      return response;
    } on FormatException catch (_) {}
  }

  @override
  Future<Transactions> getTransaction({
    required String idToken,
    required int transactionId,
  }) async {
    dynamic response = await _apiService.getResponse(
      '${ApiEndPoint().transaction}/$transactionId',
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Accept": "application/json",
        "Content-Type": "application/json",
      }),
    );
    return Transactions.fromJson(response);
  }

  @override
  Future getTransactions({
    required String idToken,
  }) async {
    dynamic response = await _apiService.getResponse(
      ApiEndPoint().transaction,
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Accept": "application/json",
        "Content-Type": "application/json",
      }),
    );

    final json = [];

    for (var item in response) {
      json.add(Transactions.fromJson(item));
    }
    return json;
  }

  @override
  Future addExpense({
    required String idToken,
    required int walletId,
    required num amount,
    String? noteComment,
    String? noteImage,
  }) async {
    try {
      dynamic response = await _apiService.postResponse(
        ApiEndPoint().transaction,
        function: 'expense',
        header: Map<String, String>.from({
          "Authorization": "Bearer $idToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
        body: jsonEncode(
          Map<String, dynamic>.from({
            "walletId": walletId,
            "amount": amount,
            "noteComment": noteComment,
            "noteImage": noteImage,
          }),
        ),
      );
      return response;
    } on FormatException catch (_) {}
  }
}
