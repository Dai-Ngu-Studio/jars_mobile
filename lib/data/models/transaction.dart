class Transactions {
  int? id;
  int? walletId;
  String? transactionDate;
  int? noteId;
  int? billId;
  int? amount;
  String? bill;
  String? note;
  String? wallet;

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
    note = json['note'];
    wallet = json['wallet'];
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
    data['note'] = note;
    data['wallet'] = wallet;
    return data;
  }
}
