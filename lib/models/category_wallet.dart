class CategoryWallets {
  int? id;
  int? walletId;
  String? name;
  int? parentCategoryId;
  int? currentCategoryLevel;
  String? wallet;

  CategoryWallets({
    this.id,
    this.walletId,
    this.name,
    this.parentCategoryId,
    this.currentCategoryLevel,
    this.wallet,
  });

  CategoryWallets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletId = json['walletId'];
    name = json['name'];
    parentCategoryId = json['parentCategoryId'];
    currentCategoryLevel = json['currentCategoryLevel'];
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['walletId'] = walletId;
    data['name'] = name;
    data['parentCategoryId'] = parentCategoryId;
    data['currentCategoryLevel'] = currentCategoryLevel;
    data['wallet'] = wallet;
    return data;
  }
}
