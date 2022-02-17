import 'package:jars_mobile/data/models/category_wallet.dart';
import 'package:jars_mobile/data/models/transaction.dart';

class Wallets {
  int? id;
  String? name;
  String? startDate;
  int? walletAmount;
  int? percentage;
  String? accountId;
  String? account;
  List<CategoryWallets>? categoryWallets;
  List<Transactions>? transactions;

  Wallets({
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

  Wallets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['startDate'];
    walletAmount = json['walletAmount'];
    percentage = json['percentage'];
    accountId = json['accountId'];
    account = json['account'];
    if (json['categoryWallets'] != null) {
      categoryWallets = <CategoryWallets>[];
      json['categoryWallets'].forEach((v) {
        categoryWallets!.add(CategoryWallets.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['startDate'] = startDate;
    data['walletAmount'] = walletAmount;
    data['percentage'] = percentage;
    data['accountId'] = accountId;
    data['account'] = account;
    if (categoryWallets != null) {
      data['categoryWallets'] =
          categoryWallets!.map((v) => v.toJson()).toList();
    }
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
