class Note {
  int? id;
  String? addedDate;
  String? comments;
  String? image;
  int? transactionId;
  int? contractId;
  double? latitude;
  double? longitude;

  Note({
    this.id,
    this.addedDate,
    this.comments,
    this.image,
    this.transactionId,
    this.contractId,
    this.latitude,
    this.longitude,
  });

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedDate = json['addedDate'];
    comments = json['comments'];
    image = json['image'];
    transactionId = json['transactionId'];
    contractId = json['contractId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['addedDate'] = addedDate;
    data['comments'] = comments;
    data['image'] = image;
    data['transactionId'] = transactionId;
    data['contractId'] = contractId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
