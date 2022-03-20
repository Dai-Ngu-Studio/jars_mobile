import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/data/repository/wallet_repository.dart';

class WalletRepositoryImpl extends WalletRepository {
  @override
  Future<List<Wallet>> getWallets({required String idToken}) {
    // TODO: implement getWallets
    throw UnimplementedError();
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
  }) {
    // TODO: implement updateWallet
    throw UnimplementedError();
  }
}
