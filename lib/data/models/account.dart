class Account {
  String? id;
  bool? isAdmin;
  String? email;
  String? displayName;
  String? photoUrl;
  String? lastLoginDate;

  Account({
    this.id,
    this.isAdmin,
    this.email,
    this.displayName,
    this.photoUrl,
    this.lastLoginDate,
  });

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isAdmin = json['isAdmin'];
    email = json['email'];
    displayName = json['displayName'];
    photoUrl = json['photoUrl'];
    lastLoginDate = json['lastLoginDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isAdmin'] = isAdmin;
    data['email'] = email;
    data['displayName'] = displayName;
    data['photoUrl'] = photoUrl;
    data['lastLoginDate'] = lastLoginDate;
    return data;
  }
}
