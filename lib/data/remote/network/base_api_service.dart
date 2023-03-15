abstract class BaseApiService {
  final String baseUrl = "http://10.0.2.2:8000/api/v1/";

  Future<dynamic> getResponse(String url, {String? function, required header});

  Future<dynamic> getResponseByID(String url, {String? function, required header, dynamic id});

  Future<dynamic> postResponse(String url, {String? function, required header, dynamic body});

  Future<dynamic> putResponse(String url, {required header, dynamic body});

  Future<dynamic> deleteResponse(String url, {required header, dynamic body});
}
