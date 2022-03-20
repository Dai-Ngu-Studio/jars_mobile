import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/data/remote/response/api_response.dart';
import 'package:jars_mobile/data/repository/wallet_repository_impl.dart';

class WalletViewModel {
  final _walletRepo = WalletRepositoryImpl();

  ApiResponse<List<Wallet>> wallet = ApiResponse.loading();

  void _setWallet(ApiResponse<List<Wallet>> response) {
    print(response);
    wallet = response;
  }

  Future<void> getWallet({required String idToken}) async {
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
}
