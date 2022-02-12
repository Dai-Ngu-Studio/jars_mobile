import 'package:jars_mobile/models/bill.dart';
import 'package:jars_mobile/models/note.dart';
import 'package:jars_mobile/models/schedule_type.dart';

class Contracts {
  int? id;
  String? accountId;
  int? scheduleTypeId;
  int? categoryId;
  int? noteId;
  String? startDate;
  String? endDate;
  int? amount;
  String? account;
  Note? note;
  ScheduleType? scheduleType;
  List<Bills>? bills;

  Contracts({
    this.id,
    this.accountId,
    this.scheduleTypeId,
    this.categoryId,
    this.noteId,
    this.startDate,
    this.endDate,
    this.amount,
    this.account,
    this.note,
    this.scheduleType,
    this.bills,
  });

  Contracts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    scheduleTypeId = json['scheduleTypeId'];
    categoryId = json['categoryId'];
    noteId = json['noteId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    amount = json['amount'];
    account = json['account'];
    note = json['note'] != null ? Note.fromJson(json['note']) : null;
    scheduleType = json['scheduleType'] != null
        ? ScheduleType.fromJson(json['scheduleType'])
        : null;
    if (json['bills'] != null) {
      bills = <Bills>[];
      json['bills'].forEach((v) {
        bills!.add(Bills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountId'] = accountId;
    data['scheduleTypeId'] = scheduleTypeId;
    data['categoryId'] = categoryId;
    data['noteId'] = noteId;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['amount'] = amount;
    data['account'] = account;
    if (note != null) {
      data['note'] = note!.toJson();
    }
    if (scheduleType != null) {
      data['scheduleType'] = scheduleType!.toJson();
    }
    if (bills != null) {
      data['bills'] = bills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
