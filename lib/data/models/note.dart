class Note {
  int? id;
  String? addedDate;
  String? comments;
  String? image;

  Note({this.id, this.addedDate, this.comments, this.image});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedDate = json['addedDate'];
    comments = json['comments'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['addedDate'] = addedDate;
    data['comments'] = comments;
    data['image'] = image;
    return data;
  }
}
