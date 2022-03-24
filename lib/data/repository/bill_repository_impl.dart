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
    required Bill bill,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Bill> getBill({
    required String idToken,
    required int billId,
  }) async {
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
}
