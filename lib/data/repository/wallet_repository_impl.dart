import 'dart:convert';
import 'dart:developer';

import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/data/remote/network/api_end_point.dart';
import 'package:jars_mobile/data/remote/network/base_api_service.dart';
import 'package:jars_mobile/data/remote/network/network_api_service.dart';
import 'package:jars_mobile/data/repository/interface/wallet_repository.dart';

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
  Future<Wallet> getWallet({required String idToken, required int walletId}) async {
    try {
      dynamic response = await _apiService.getResponse(
        '${ApiEndPoint().wallet}/$walletId',
        header: Map<String, String>.from({
          "Authorization": "Bearer $idToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
      );
      return Wallet.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> updateWallet({required String idToken, required Wallet wallet}) async {
    try {
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
      if (!e
          .toString()
          .contains("This account already have more than 1 wallet, cannot create 6 default jars")) {
        rethrow;
      }
    }
  }

  @override
  Future getWalletSpent({required String idToken, required String walletId}) async {
    try {
      dynamic response = await _apiService.getResponseByID(
        ApiEndPoint().wallet,
        function: "wallet-spend",
        id: walletId,
        header: Map<String, String>.from({
          "Authorization": "Bearer $idToken",
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
      );

      return Wallet.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future getWalletsSpent({required String idToken}) async {
    try {
      dynamic response = await _apiService.getResponse(
        ApiEndPoint().wallet,
        function: "six-wallets-spend",
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
}
