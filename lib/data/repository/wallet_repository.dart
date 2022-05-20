import 'package:jars_mobile/data/models/wallet.dart';

abstract class WalletRepository {
  Future getWallets({required String idToken});

  Future<Wallet> getWallet({required String idToken, required int walletId});

  Future<void> updateWallet({required String idToken, required Wallet wallet});

  Future<void> generateSixJars({required String idToken});

  Future<void> getWalletSpent({
    required String idToken,
    required String walletId,
  });

  Future<void> getWalletsSpent({required String idToken});
}
