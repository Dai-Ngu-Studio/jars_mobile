import 'package:jars_mobile/data/models/account.dart';
import 'package:jars_mobile/data/models/note.dart';
import 'package:jars_mobile/data/models/schedule_type.dart';

class Contract {
  int? id;
  String? accountId;
  int? scheduleTypeId;
  int? categoryId;
  int? noteId;
  String? startDate;
  String? endDate;
  int? amount;
  Account? account;
  Note? note;
  ScheduleType? scheduleType;

  Contract({
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
  });

  Contract.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    scheduleTypeId = json['scheduleTypeId'];
    categoryId = json['categoryId'];
    noteId = json['noteId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    amount = json['amount'];
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    note = json['note'] != null ? Note.fromJson(json['note']) : null;
    scheduleType = json['scheduleType'] != null
        ? ScheduleType.fromJson(json['scheduleType'])
        : null;
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
    if (account != null) {
      data['account'] = account!.toJson();
    }
    if (note != null) {
      data['note'] = note!.toJson();
    }
    if (scheduleType != null) {
      data['scheduleType'] = scheduleType!.toJson();
    }
    return data;
  }
}
