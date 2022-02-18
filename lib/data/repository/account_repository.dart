import 'package:jars_mobile/data/models/account.dart';

abstract class AccountRepository {
  Future<void> login(String idToken);

  Future<Account> getAccount(String accountId);

  Future<void> deleteAccount(String accountId);
}
