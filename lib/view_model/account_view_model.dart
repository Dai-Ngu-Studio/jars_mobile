import 'package:jars_mobile/data/models/account.dart';
import 'package:jars_mobile/data/remote/response/api_response.dart';
import 'package:jars_mobile/data/repository/account_repository_impl.dart';

class AccountViewModel {
  final _accountRepo = AccountRepositoryImpl();

  ApiResponse<Account> account = ApiResponse.loading();

  void _setAccount(ApiResponse<Account> response) {
    print(response);
    account = response;
  }

  Future<void> login({required String idToken, String? fcmToken}) async {
    _setAccount(ApiResponse.loading());
    await _accountRepo
        .login(idToken: idToken, fcmToken: fcmToken)
        .whenComplete(() => _setAccount(ApiResponse.completed(null)))
        .onError(
          (error, stackTrace) => _setAccount(
            ApiResponse.error(error.toString()),
          ),
        );
  }
}
