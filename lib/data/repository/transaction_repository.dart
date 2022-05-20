import 'package:jars_mobile/data/models/transaction.dart';

abstract class TransactionRepository {
  Future getTransactions({
    required String idToken,
  });

  Future<Transactions> getTransaction({
    required String idToken,
    required int transactionId,
  });

  Future addIncome({
    required String idToken,
    required num amount,
    String? noteComment,
    String? noteImage,
  });

  Future addExpense({
    required String idToken,
    required int walletId,
    required num amount,
    String? noteComment,
    String? noteImage,
  });
}
