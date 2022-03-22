import 'package:flutter/cupertino.dart';
import 'package:jars_mobile/data/remote/response/api_response.dart';
import 'package:jars_mobile/data/repository/transaction_repository_impl.dart';

class TransactionViewModel extends ChangeNotifier {
  final _transactionRepo = TransactionRepositoryImpl();

  ApiResponse<List> transactions = ApiResponse.loading();

  void _setTransactions(ApiResponse<List> response) {
    transactions = response;
    notifyListeners();
  }

  Future getTransactions({required String idToken}) async {
    _setTransactions(ApiResponse.loading());
    await _transactionRepo
        .getTransactions(idToken: idToken)
        .then(((value) => _setTransactions(ApiResponse.completed(value))))
        .onError(
          (error, stackTrace) => _setTransactions(
            ApiResponse.error(error.toString()),
          ),
        );
  }
}
