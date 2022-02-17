class CategoryWallets {
  int? id;
  int? walletId;
  String? name;
  int? parentCategoryId;
  int? currentCategoryLevel;
  String? parentCategory;
  String? wallet;
  List<String>? inverseParentCategory;

  CategoryWallets({
    this.id,
    this.walletId,
    this.name,
    this.parentCategoryId,
    this.currentCategoryLevel,
    this.parentCategory,
    this.wallet,
    this.inverseParentCategory,
  });

  CategoryWallets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletId = json['walletId'];
    name = json['name'];
    parentCategoryId = json['parentCategoryId'];
    currentCategoryLevel = json['currentCategoryLevel'];
    parentCategory = json['parentCategory'];
    wallet = json['wallet'];
    inverseParentCategory = json['inverseParentCategory'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['walletId'] = walletId;
    data['name'] = name;
    data['parentCategoryId'] = parentCategoryId;
    data['currentCategoryLevel'] = currentCategoryLevel;
    data['parentCategory'] = parentCategory;
    data['wallet'] = wallet;
    data['inverseParentCategory'] = inverseParentCategory;
    return data;
  }
}
