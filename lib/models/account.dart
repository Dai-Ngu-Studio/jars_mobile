import 'package:jars_mobile/models/account_type.dart';
import 'package:jars_mobile/models/contract.dart';
import 'package:jars_mobile/models/wallet.dart';

class Account {
  String? id;
  int? accountTypeId;
  String? email;
  String? displayName;
  String? photoUrl;
  String? lastLoginDate;
  AccountType? accountType;
  List<Contracts>? contracts;
  List<Wallets>? wallets;

  Account({
    this.id,
    this.accountTypeId,
    this.email,
    this.displayName,
    this.photoUrl,
    this.lastLoginDate,
    this.accountType,
    this.contracts,
    this.wallets,
  });

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountTypeId = json['accountTypeId'];
    email = json['email'];
    displayName = json['displayName'];
    photoUrl = json['photoUrl'];
    lastLoginDate = json['lastLoginDate'];
    accountType = json['accountType'] != null
        ? AccountType.fromJson(json['accountType'])
        : null;
    if (json['contracts'] != null) {
      contracts = <Contracts>[];
      json['contracts'].forEach((v) {
        contracts!.add(Contracts.fromJson(v));
      });
    }
    if (json['wallets'] != null) {
      wallets = <Wallets>[];
      json['wallets'].forEach((v) {
        wallets!.add(Wallets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountTypeId'] = accountTypeId;
    data['email'] = email;
    data['displayName'] = displayName;
    data['photoUrl'] = photoUrl;
    data['lastLoginDate'] = lastLoginDate;
    if (accountType != null) {
      data['accountType'] = accountType!.toJson();
    }
    if (contracts != null) {
      data['contracts'] = contracts!.map((v) => v.toJson()).toList();
    }
    if (wallets != null) {
      data['wallets'] = wallets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
