import 'package:jars_mobile/data/models/bill_details.dart';
import 'package:jars_mobile/data/models/category.dart';
import 'package:jars_mobile/data/models/transaction.dart';

class Bills {
  int? id;
  String? date;
  String? name;
  int? amount;
  int? recurringTransactionId;
  int? leftAmount;
  int? categoryId;
  int? contractId;
  Category? category;
  String? contract;
  List<BillDetails>? billDetails;
  List<Transactions>? transactions;

  Bills({
    this.id,
    this.date,
    this.name,
    this.amount,
    this.recurringTransactionId,
    this.leftAmount,
    this.categoryId,
    this.contractId,
    this.category,
    this.contract,
    this.billDetails,
    this.transactions,
  });

  Bills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    name = json['name'];
    amount = json['amount'];
    recurringTransactionId = json['recurringTransactionId'];
    leftAmount = json['leftAmount'];
    categoryId = json['categoryId'];
    contractId = json['contractId'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    contract = json['contract'];
    if (json['billDetails'] != null) {
      billDetails = <BillDetails>[];
      json['billDetails'].forEach((v) {
        billDetails!.add(BillDetails.fromJson(v));
      });
    }
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
    data['date'] = date;
    data['name'] = name;
    data['amount'] = amount;
    data['recurringTransactionId'] = recurringTransactionId;
    data['leftAmount'] = leftAmount;
    data['categoryId'] = categoryId;
    data['contractId'] = contractId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['contract'] = contract;
    if (billDetails != null) {
      data['billDetails'] = billDetails!.map((v) => v.toJson()).toList();
    }
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
