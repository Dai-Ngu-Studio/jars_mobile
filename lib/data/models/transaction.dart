class Transactions {
  int? id;
  int? walletId;
  String? transactionDate;
  int? noteId;
  int? billId;
  int? amount;

  Transactions({
    this.id,
    this.walletId,
    this.transactionDate,
    this.noteId,
    this.billId,
    this.amount,
  });

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletId = json['walletId'];
    transactionDate = json['transactionDate'];
    noteId = json['noteId'];
    billId = json['billId'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['walletId'] = walletId;
    data['transactionDate'] = transactionDate;
    data['noteId'] = noteId;
    data['billId'] = billId;
    data['amount'] = amount;
    return data;
  }
}
