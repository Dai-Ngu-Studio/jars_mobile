class Account {
  String? id;
  int? accountTypeId;
  String? email;
  String? displayName;
  String? photoUrl;
  String? lastLoginDate;

  Account({
    this.id,
    this.accountTypeId,
    this.email,
    this.displayName,
    this.photoUrl,
    this.lastLoginDate,
  });

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountTypeId = json['accountTypeId'];
    email = json['email'];
    displayName = json['displayName'];
    photoUrl = json['photoUrl'];
    lastLoginDate = json['lastLoginDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountTypeId'] = accountTypeId;
    data['email'] = email;
    data['displayName'] = displayName;
    data['photoUrl'] = photoUrl;
    data['lastLoginDate'] = lastLoginDate;
    return data;
  }
}
