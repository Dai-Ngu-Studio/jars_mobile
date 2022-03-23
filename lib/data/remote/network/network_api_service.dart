import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jars_mobile/data/remote/app_exception.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getResponse(String url, {String? function, required header}) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        function == null
            ? Uri.parse("$baseUrl$url")
            : Uri.parse("$baseUrl$url/$function"),
        headers: header,
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getResponseByID(
    String url, {
    String? function,
    required header,
    dynamic id,
  }) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        function == null
            ? Uri.parse("$baseUrl$url/$id")
            : Uri.parse("$baseUrl$url/$function/$id"),
        headers: header,
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(String url,
      {String? function, required header, body}) async {
    dynamic responseJson;
    try {
      function == null
          ? print("NetworkApiService :: postResponse: $baseUrl$url")
          : print("NetworkApiService :: postResponse: $baseUrl$url/$function");

      final response = await http.post(
        function == null
            ? Uri.parse("$baseUrl$url")
            : Uri.parse("$baseUrl$url/$function"),
        headers: header,
        body: body,
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future putResponse(String url, {required header, body}) async {
    dynamic responseJson;
    try {
      print("NetworkApiService :: putResponse: $baseUrl$url");

      final response = await http.put(
        Uri.parse("$baseUrl$url"),
        headers: header,
        body: body,
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future deleteResponse(String url, {required header, body}) async {
    dynamic responseJson;
    try {
      print("NetworkApiService :: putResponse: $baseUrl$url");

      final response = await http.put(
        Uri.parse("$baseUrl$url"),
        headers: header,
        body: body,
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 201:
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
          'Error occured while communication with server with status code : ${response.statusCode}',
        );
    }
  }
}
