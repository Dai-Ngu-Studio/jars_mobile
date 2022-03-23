abstract class CloudRepository {
  Future<String> uploadImage({required String idToken, required String base64});
}
