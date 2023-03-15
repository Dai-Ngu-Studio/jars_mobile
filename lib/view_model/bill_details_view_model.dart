import 'package:flutter/material.dart';
import 'package:jars_mobile/data/remote/response/api_response.dart';
import 'package:jars_mobile/data/repository/bill_details_repository_impl.dart';

class BillDetailsViewModel extends ChangeNotifier {
  final _billDetailsRepo = BillDetailsRepositoryImpl();

  ApiResponse<List> billDetails = ApiResponse.loading();

  void _setBillDetails(ApiResponse<List> response) {
    billDetails = response;
    notifyListeners();
  }

  Future getBillDetails({required String idToken, required int billId}) async {
    _setBillDetails(ApiResponse.loading());
    await _billDetailsRepo
        .getBillDetails(idToken: idToken, billId: billId)
        .then((value) => _setBillDetails(ApiResponse.completed(value)))
        .onError((error, stackTrace) => _setBillDetails(ApiResponse.error(error.toString())));
  }
}
