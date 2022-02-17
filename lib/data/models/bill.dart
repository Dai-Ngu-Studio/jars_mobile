import 'package:jars_mobile/data/models/bill_details.dart';
import 'package:jars_mobile/data/models/category.dart';
import 'package:jars_mobile/data/models/contract.dart';
import 'package:jars_mobile/data/models/transaction.dart';

class Bill {
  int? id;
  String? date;
  String? name;
  int? amount;
  int? leftAmount;
  int? categoryId;
  int? contractId;
  Category? category;
  Contract? contract;
  List<BillDetails>? billDetails;
  List<Transactions>? transactions;

  Bill({
    this.id,
    this.date,
    this.name,
    this.amount,
    this.leftAmount,
    this.categoryId,
    this.contractId,
    this.category,
    this.contract,
    this.billDetails,
    this.transactions,
  });

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    name = json['name'];
    amount = json['amount'];
    leftAmount = json['leftAmount'];
    categoryId = json['categoryId'];
    contractId = json['contractId'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    contract =
        json['contract'] != null ? Contract.fromJson(json['contract']) : null;
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
    data['leftAmount'] = leftAmount;
    data['categoryId'] = categoryId;
    data['contractId'] = contractId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (contract != null) {
      data['contract'] = contract!.toJson();
    }
    if (billDetails != null) {
      data['billDetails'] = billDetails!.map((v) => v.toJson()).toList();
    }
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
