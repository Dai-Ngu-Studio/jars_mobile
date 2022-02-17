import 'package:jars_mobile/data/models/account.dart';
import 'package:jars_mobile/data/models/category_wallet.dart';

class Wallet {
  int? id;
  String? name;
  String? startDate;
  int? walletAmount;
  int? percentage;
  String? accountId;
  Account? account;
  List<CategoryWallets>? categoryWallets;
  List<String>? transactions;

  Wallet({
    this.id,
    this.name,
    this.startDate,
    this.walletAmount,
    this.percentage,
    this.accountId,
    this.account,
    this.categoryWallets,
    this.transactions,
  });

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['startDate'];
    walletAmount = json['walletAmount'];
    percentage = json['percentage'];
    accountId = json['accountId'];
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    if (json['categoryWallets'] != null) {
      categoryWallets = <CategoryWallets>[];
      json['categoryWallets'].forEach((v) {
        categoryWallets!.add(CategoryWallets.fromJson(v));
      });
    }
    transactions = json['transactions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['startDate'] = startDate;
    data['walletAmount'] = walletAmount;
    data['percentage'] = percentage;
    data['accountId'] = accountId;
    if (account != null) {
      data['account'] = account!.toJson();
    }
    if (categoryWallets != null) {
      data['categoryWallets'] =
          categoryWallets!.map((v) => v.toJson()).toList();
    }
    data['transactions'] = transactions;
    return data;
  }
}
