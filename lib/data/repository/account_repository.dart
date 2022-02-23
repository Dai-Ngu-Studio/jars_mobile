import 'package:jars_mobile/data/models/account.dart';

abstract class AccountRepository {
  Future<void> login({required String idToken});

  Future<Account> getAccount({required token, required String accountId});

  Future<Account> updateAccount({required token, required Account account});

  Future<void> deleteAccount({required token, required String accountId});
}
