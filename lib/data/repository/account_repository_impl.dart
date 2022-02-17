import 'dart:developer';

import 'package:jars_mobile/data/models/account.dart';
import 'package:jars_mobile/data/remote/network/api_end_point.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';
import 'package:jars_mobile/data/remote/network/network_api_service.dart';
import 'package:jars_mobile/data/repository/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<Account> getAccount(String accountId) async {
    try {
      dynamic response = await _apiService.getResponse(
        ApiEndPoint().getAccount,
      );

      log('response: $response');

      final json = Account.fromJson(response);

      return json;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
