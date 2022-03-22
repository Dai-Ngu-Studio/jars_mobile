import 'package:jars_mobile/data/models/transaction.dart';

abstract class TransactionRepository {
  Future getTransactions({required String idToken});

  Future<Transactions> getTransaction(
      {required String idToken, required String transactionId});

  Future<Transactions> createTransaction(
      {required String idToken, required Transactions transaction});
}
