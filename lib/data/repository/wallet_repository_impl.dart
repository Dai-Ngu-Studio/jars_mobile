import 'dart:convert';
import 'dart:developer';

import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/data/remote/network/api_end_point.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';
import 'package:jars_mobile/data/remote/network/network_api_service.dart';
import 'package:jars_mobile/data/repository/wallet_repository.dart';

class WalletRepositoryImpl extends WalletRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future getWallets({required String idToken}) async {
    try {
      dynamic response = await _apiService.getResponse(
        ApiEndPoint().wallet,
        header: Map<String, String>.from({
          "Authorization": "Bearer $idToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
      );
      final json = [];

      for (var item in response) {
        json.add(Wallet.fromJson(item));
      }
      return json;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Wallet> getWallet({
    required String idToken,
    required String walletId,
  }) {
    // TODO: implement getWallet
    throw UnimplementedError();
  }

  @override
  Future<void> updateWallet({
    required String idToken,
    required Wallet wallet,
  }) async {
    try {
      print(jsonEncode(wallet.toJson()));
      dynamic response = await _apiService.putResponse(
        "${ApiEndPoint().wallet}/${wallet.id}",
        header: Map<String, String>.from({
          "Authorization": "Bearer $idToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
        body: jsonEncode(wallet.toJson()),
      );
      log('WalletRepositoryImpl :: updateWallet :: response: $response');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future generateSixJars({required String idToken}) async {
    try {
      dynamic response = await _apiService.postResponse(
        ApiEndPoint().wallet,
        function: "six-wallets",
        header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
      );
      log('WalletRepositoryImpl :: generateSixJars :: response: $response');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
