import 'package:flutter/material.dart';
import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/data/remote/response/api_response.dart';
import 'package:jars_mobile/data/repository/wallet_repository_impl.dart';

class WalletViewModel extends ChangeNotifier {
  final _walletRepo = WalletRepositoryImpl();

  ApiResponse<List> wallet = ApiResponse.loading();

  void _setWallet(ApiResponse<List> response) {
    print(response);
    wallet = response;
    notifyListeners();
  }

  Future getWallet({required String idToken}) async {
    _setWallet(ApiResponse.loading());
    await _walletRepo
        .getWallets(idToken: idToken)
        .then((value) => _setWallet(ApiResponse.completed(value)))
        .onError(
          (error, stackTrace) => _setWallet(
            ApiResponse.error(error.toString()),
          ),
        );
  }

  Future putWallet({required String idToken, required Wallet wallet}) async {
    _setWallet(ApiResponse.loading());
    await _walletRepo
        .updateWallet(idToken: idToken, wallet: wallet)
        .whenComplete(() => _setWallet(ApiResponse.completed(null)))
        .onError(
          (error, stackTrace) => _setWallet(
            ApiResponse.error(error.toString()),
          ),
        );
  }

  Future<void> generateSixJars({required String idToken}) async {
    _setWallet(ApiResponse.loading());
    _walletRepo
        .generateSixJars(idToken: idToken)
        .whenComplete(() => _setWallet(ApiResponse.completed(null)))
        .onError(
          (error, stackTrace) => _setWallet(
            ApiResponse.error(error.toString()),
          ),
        );
  }
}
