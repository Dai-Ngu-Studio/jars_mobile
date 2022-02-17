class AccountType {
  int? id;
  String? name;
  List<String>? accounts;

  AccountType({this.id, this.name, this.accounts});

  AccountType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accounts = json['accounts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['accounts'] = accounts;
    return data;
  }
}
