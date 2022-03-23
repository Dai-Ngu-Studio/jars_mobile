import 'package:jars_mobile/data/models/bill_details.dart';

class Bill {
  int? id;
  String? date;
  String? name;
  num? amount;
  num? leftAmount;
  int? categoryId;
  int? contractId;
  int? statusCode;
  String? accountId;
  List<BillDetails>? billDetails;

  Bill({
    this.id,
    this.date,
    this.name,
    this.amount,
    this.leftAmount,
    this.categoryId,
    this.contractId,
    this.statusCode,
    this.accountId,
    this.billDetails,
  });

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    name = json['name'];
    amount = json['amount'];
    leftAmount = json['leftAmount'];
    categoryId = json['categoryId'];
    contractId = json['contractId'];
    statusCode = json['statusCode'];
    accountId = json['accountId'];
    if (json['billDetails'] != null) {
      billDetails = <BillDetails>[];
      json['billDetails'].forEach((v) {
        billDetails!.add(BillDetails.fromJson(v));
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
    data['statusCode'] = statusCode;
    data['accountId'] = accountId;
    if (billDetails != null) {
      data['billDetails'] = billDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
