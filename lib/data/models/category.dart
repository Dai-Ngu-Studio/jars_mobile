class Category {
  int? id;
  String? name;
  int? parentCategoryId;
  int? currentCategoryLevel;

  Category({
    this.id,
    this.name,
    this.parentCategoryId,
    this.currentCategoryLevel,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentCategoryId = json['parentCategoryId'];
    currentCategoryLevel = json['currentCategoryLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parentCategoryId'] = parentCategoryId;
    data['currentCategoryLevel'] = currentCategoryLevel;
    return data;
  }
}
