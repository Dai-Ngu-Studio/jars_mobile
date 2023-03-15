import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jars_mobile/data/models/bill.dart';
import 'package:jars_mobile/data/remote/response/api_response.dart';
import 'package:jars_mobile/data/repository/bill_repository_impl.dart';

class BillViewModel extends ChangeNotifier {
  final _billRepo = BillRepositoryImpl();

  ApiResponse<List> bills = ApiResponse.loading();

  void _setBill(ApiResponse<List> response) {
    bills = response;
    notifyListeners();
  }

  Future getBills({required String idToken, required int page}) async {
    // _setBill(ApiResponse.loading());
    return await _billRepo
        .getBills(idToken: idToken, page: page)
        .then((value) => _setBill(ApiResponse.completed(value)))
        .onError((error, stackTrace) => _setBill(ApiResponse.error(error.toString())));
  }

  Future<Bill> getBill({required String idToken, required int billId}) async {
    return await _billRepo.getBill(idToken: idToken, billId: billId);
  }

  Future<Bill> createBill({
    required String idToken,
    required String name,
    required String date,
    required List<dynamic> billDetails,
  }) async {
    return await _billRepo
        .createBill(idToken: idToken, name: name, date: date, billDetails: billDetails)
        .then((value) => value)
        .whenComplete(() => _setBill(ApiResponse.completed(null)))
        .catchError(
      (error, stackTrace) {
        _setBill(ApiResponse.error(error.toString()));
      },
    );
  }

  Future updateBill({
    required String idToken,
    required int billId,
    required int walletId,
    required String? name,
    required String? date,
    required num leftAmount,
  }) async {
    await _billRepo
        .updateBill(
          idToken: idToken,
          billId: billId,
          walletId: walletId,
          name: name,
          date: date,
          leftAmount: leftAmount,
        )
        .whenComplete(() => _setBill(ApiResponse.completed(null)))
        .onError((error, stackTrace) => _setBill(ApiResponse.error(error.toString())));
  }
}
