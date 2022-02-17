import 'package:jars_mobile/data/models/note.dart';
import 'package:jars_mobile/data/models/wallet.dart';

class Transactions {
  int? id;
  int? walletId;
  String? transactionDate;
  int? noteId;
  int? billId;
  int? amount;
  String? bill;
  Note? note;
  Wallet? wallet;

  Transactions({
    this.id,
    this.walletId,
    this.transactionDate,
    this.noteId,
    this.billId,
    this.amount,
    this.bill,
    this.note,
    this.wallet,
  });

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletId = json['walletId'];
    transactionDate = json['transactionDate'];
    noteId = json['noteId'];
    billId = json['billId'];
    amount = json['amount'];
    bill = json['bill'];
    note = json['note'] != null ? Note.fromJson(json['note']) : null;
    wallet = json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['walletId'] = walletId;
    data['transactionDate'] = transactionDate;
    data['noteId'] = noteId;
    data['billId'] = billId;
    data['amount'] = amount;
    data['bill'] = bill;
    if (note != null) {
      data['note'] = note!.toJson();
    }
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    return data;
  }
}
