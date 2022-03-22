import 'package:jars_mobile/data/models/transaction.dart';
import 'package:jars_mobile/data/remote/network/api_end_point.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';
import 'package:jars_mobile/data/remote/network/network_api_service.dart';
import 'package:jars_mobile/data/repository/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<Transactions> createTransaction({
    required String idToken,
    required Transactions transaction,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<Transactions> getTransaction(
      {required String idToken, required String transactionId}) {
    throw UnimplementedError();
  }

  @override
  Future getTransactions({required String idToken}) async {
    try {
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
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
