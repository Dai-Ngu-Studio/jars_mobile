abstract class BaseApiService {
  final String baseUrl = "https://14.225.254.190:8001/api/v1/";

  Future<dynamic> getResponse(String url, {required header});

  Future<dynamic> getResponseByID(String url, {required header, dynamic id});

  Future<dynamic> postResponse(
    String url, {
    String? function,
    required header,
    dynamic body,
  });

  Future<dynamic> putResponse(String url, {required header, dynamic body});

  Future<dynamic> deleteResponse(String url, {required header, dynamic body});
}
