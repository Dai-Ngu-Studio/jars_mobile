import 'dart:developer';

import 'package:jars_mobile/data/models/account.dart';
import 'package:jars_mobile/data/remote/network/api_end_point.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';
import 'package:jars_mobile/data/remote/network/network_api_service.dart';
import 'package:jars_mobile/data/repository/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<void> login({required String idToken, String? fcmToken}) async {
    try {
      dynamic response = await _apiService.postResponse(
        ApiEndPoint().account,
        function: "login",
        header: Map<String, String>.from({
          "Authorization": "Bearer $idToken",
          "FcmToken": fcmToken,
        }),
      );

      log('AccountRepositoryImpl :: login :: response: $response');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Account> getAccount({required token}) async {
    // TODO: implement updateAccount
    throw UnimplementedError();
  }

  @override
  Future<Account> updateAccount({required token, required Account account}) {
    // TODO: implement updateAccount
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount({required token, required String accountId}) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }
}
