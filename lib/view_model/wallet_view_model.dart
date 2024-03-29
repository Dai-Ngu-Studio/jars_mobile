import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/data/remote/response/api_response.dart';
import 'package:jars_mobile/data/repository/wallet_repository_impl.dart';

class WalletViewModel extends ChangeNotifier {
  final _walletRepo = WalletRepositoryImpl();

  ApiResponse<List> wallet = ApiResponse.loading();

  void _setWallet(ApiResponse<List> response) {
    log(response.toString());
    wallet = response;
    notifyListeners();
  }

  Future getWallet({required String idToken}) async {
    _setWallet(ApiResponse.loading());
    try {
      List wallets = await _walletRepo.getWallets(idToken: idToken);
      List walletsSpent = await _walletRepo.getWalletsSpent(idToken: idToken);
      List<Wallet> walletFullProps = [];
      for (var wallet in wallets) {
        final walletSpent = walletsSpent.firstWhere((walletSpent) => walletSpent.id == wallet.id);
        walletFullProps.add(
          Wallet(
            id: wallet.id,
            accountId: wallet.accountId,
            categoryWalletId: wallet.categoryWalletId,
            name: wallet.name,
            percentage: wallet.percentage,
            startDate: wallet.startDate,
            walletAmount: wallet.walletAmount,
            amountLeft: walletSpent.amountLeft,
            totalSpend: -walletSpent.totalSpend,
            totalAdded: walletSpent.totalAdded,
          ),
        );
      }
      _setWallet(ApiResponse.completed(walletFullProps));
    } catch (e) {
      _setWallet(ApiResponse.error(e.toString()));
    }
  }

  Future putWallet({required String idToken, required Wallet wallet}) async {
    try {
      _setWallet(ApiResponse.loading());
      await _walletRepo.updateWallet(idToken: idToken, wallet: wallet);
      _setWallet(ApiResponse.completed(null));
    } catch (e) {
      _setWallet(ApiResponse.error(e.toString()));
      rethrow;
    }
  }

  Future<bool> generateSixJars({required String idToken}) async {
    try {
      _setWallet(ApiResponse.loading());
      await _walletRepo.generateSixJars(idToken: idToken);
      _setWallet(ApiResponse.completed(null));
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future getWalletSpent({required String idToken, required String walletId}) async {
    try {
      _setWallet(ApiResponse.loading());
      await _walletRepo.getWalletSpent(idToken: idToken, walletId: walletId);
      _setWallet(ApiResponse.completed(null));
    } catch (e) {
      _setWallet(ApiResponse.error(e.toString()));
      rethrow;
    }
  }

  Future getWalletsSpent({required String idToken}) async {
    _setWallet(ApiResponse.loading());
    _walletRepo
        .getWalletsSpent(idToken: idToken)
        .whenComplete(() => _setWallet(ApiResponse.completed(null)))
        .onError((error, stackTrace) => _setWallet(ApiResponse.error(error.toString())));
  }

  Future<Wallet> getAWallet({required String idToken, required int walletId}) async {
    _setWallet(ApiResponse.loading());
    return await _walletRepo.getWallet(idToken: idToken, walletId: walletId);
  }

  Future<List> getWallets({required String idToken}) async {
    return await _walletRepo.getWallets(idToken: idToken);
  }
}
