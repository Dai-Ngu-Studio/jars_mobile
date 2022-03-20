import 'package:jars_mobile/data/models/wallet.dart';

abstract class WalletRepository {
  Future<List<Wallet>> getWallets({required String idToken});

  Future<Wallet> getWallet({required String idToken, required String walletId});

  Future<void> updateWallet({required String idToken, required Wallet wallet});
}
