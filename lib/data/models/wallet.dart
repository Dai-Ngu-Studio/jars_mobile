class Wallet {
  int? id;
  String? name;
  String? startDate;
  num? walletAmount;
  int? percentage;
  String? accountId;
  int? categoryWalletId;
  num? totalAdded;
  num? totalSpend;
  num? ammountLeft;

  Wallet({
    this.id,
    this.name,
    this.startDate,
    this.walletAmount,
    this.percentage,
    this.accountId,
    this.categoryWalletId,
    this.totalAdded,
    this.totalSpend,
    this.ammountLeft,
  });

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['startDate'];
    walletAmount = json['walletAmount'];
    percentage = json['percentage'];
    accountId = json['accountId'];
    categoryWalletId = json['categoryWalletId'];
    totalAdded = json['totalAdded'];
    totalSpend = json['totalSpend'];
    ammountLeft = json['ammountLeft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['startDate'] = startDate;
    data['walletAmount'] = walletAmount;
    data['percentage'] = percentage;
    data['accountId'] = accountId;
    data['categoryWalletId'] = categoryWalletId;
    data['totalAdded'] = totalAdded;
    data['totalSpend'] = totalSpend;
    data['ammountLeft'] = ammountLeft;
    return data;
  }
}
