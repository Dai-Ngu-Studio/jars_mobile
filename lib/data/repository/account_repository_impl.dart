import 'dart:developer';

import 'package:jars_mobile/data/models/account.dart';
import 'package:jars_mobile/data/remote/network/api_end_point.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';
import 'package:jars_mobile/data/remote/network/network_api_service.dart';
import 'package:jars_mobile/data/repository/interface/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<Account> login({required String idToken, String? fcmToken}) async {
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

      return Account.fromJson(response);
    } catch (_) {
      rethrow;
    }
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
