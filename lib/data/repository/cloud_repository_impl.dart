import 'package:jars_mobile/data/remote/network/api_end_point.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';
import 'package:jars_mobile/data/remote/network/network_api_service.dart';
import 'package:jars_mobile/data/repository/interface/cloud_repository.dart';

class CloudRepositoryImpl extends CloudRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<String> uploadImage({required String idToken, required String base64}) async {
    try {
      dynamic response = await _apiService.postResponse(
        ApiEndPoint().cloud,
        function: "image",
        header: Map<String, String>.from({
          "Authorization": "Bearer $idToken",
          "Accept": "*/*",
          "Content-Type": "text/plain",
        }),
        body: base64,
      );
      return response["imageUrl"];
    } catch (_) {
      rethrow;
    }
  }
}
