import 'package:jars_mobile/data/models/bill_details.dart';
import 'package:jars_mobile/data/remote/network/api_end_point.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';
import 'package:jars_mobile/data/remote/network/network_api_service.dart';
import 'package:jars_mobile/data/repository/bill_details_repository.dart';

class BillDetailsRepositoryImpl extends BillDetailsRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future getBillDetails({required String idToken, required int billId}) async {
    dynamic response = await _apiService.getResponse(
      '${ApiEndPoint().billDetail}?bill_id=$billId',
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Accept": "application/json",
        "Content-Type": "application/json",
      }),
    );
    final json = [];
    for (var item in response) {
      json.add(BillDetails.fromJson(item));
    }
    return json;
  }
}
