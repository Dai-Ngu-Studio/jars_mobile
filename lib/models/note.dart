import 'package:jars_mobile/models/transaction.dart';

class Note {
  int? id;
  String? addedDate;
  String? comments;
  String? image;
  List<String>? contracts;
  List<Transactions>? transactions;

  Note({
    this.id,
    this.addedDate,
    this.comments,
    this.image,
    this.contracts,
    this.transactions,
  });

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedDate = json['addedDate'];
    comments = json['comments'];
    image = json['image'];
    contracts = json['contracts'].cast<String>();
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['addedDate'] = addedDate;
    data['comments'] = comments;
    data['image'] = image;
    data['contracts'] = contracts;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
