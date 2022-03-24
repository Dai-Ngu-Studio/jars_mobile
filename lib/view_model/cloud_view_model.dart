import 'package:jars_mobile/data/repository/cloud_repository_impl.dart';

class CloudViewModel {
  final _cloudRepo = CloudRepositoryImpl();

  Future<String> uploadImage({
    required String idToken,
    required String base64,
  }) async {
    return await _cloudRepo.uploadImage(
      idToken: idToken,
      base64: base64,
    );
  }
}
