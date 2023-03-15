import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jars_mobile/data/models/transaction.dart';
import 'package:jars_mobile/data/remote/response/api_response.dart';
import 'package:jars_mobile/data/repository/transaction_repository_impl.dart';

class TransactionViewModel extends ChangeNotifier {
  final _transactionRepo = TransactionRepositoryImpl();

  ApiResponse<List> transactions = ApiResponse.loading();

  void _setTransactions(ApiResponse<List> response) {
    transactions = response;
    notifyListeners();
  }

  Future<bool> addIncome({
    required String idToken,
    required num amount,
    String? noteComment,
    String? noteImage,
  }) async {
    _setTransactions(ApiResponse.loading());
    try {
      await _transactionRepo.addIncome(
        idToken: idToken,
        amount: amount,
        noteComment: noteComment,
        noteImage: noteImage,
      );
      _setTransactions(ApiResponse.completed(null));
      return true;
    } catch (e) {
      _setTransactions(ApiResponse.error(e.toString()));
      rethrow;
    }
  }

  Future getTransactions({required String idToken}) async {
    _setTransactions(ApiResponse.loading());
    await _transactionRepo
        .getTransactions(idToken: idToken)
        .then((value) => _setTransactions(ApiResponse.completed(value)))
        .onError((error, stackTrace) => _setTransactions(ApiResponse.error(error.toString())));
  }

  Future<Transactions> getTransaction({required String idToken, required int transactionId}) async {
    _setTransactions(ApiResponse.loading());
    return await _transactionRepo
        .getTransaction(idToken: idToken, transactionId: transactionId)
        .whenComplete(() => _setTransactions(ApiResponse.completed(null)))
        .catchError((error, stackTrace) {
      _setTransactions(ApiResponse.error(error.toString()));
    });
  }

  Future<bool> addExpense({
    required String idToken,
    required num amount,
    required int walletId,
    String? noteComment,
    String? noteImage,
  }) async {
    _setTransactions(ApiResponse.loading());
    try {
      await _transactionRepo.addExpense(
        idToken: idToken,
        walletId: walletId,
        amount: amount,
        noteComment: noteComment,
        noteImage: noteImage,
      );
      _setTransactions(ApiResponse.completed(null));
      return true;
    } catch (e) {
      _setTransactions(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}
