abstract class BaseApiService {
  final String baseUrl = "https://14.225.254.190:8001/api/v1/";

  Future<dynamic> getResponse(String url);
}
