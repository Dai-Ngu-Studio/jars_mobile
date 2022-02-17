import 'package:jars_mobile/data/models/account.dart';

abstract class AccountRepository {
  Future<Account> getAccount(String accountId);
}
