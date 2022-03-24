import 'package:jars_mobile/data/models/note.dart';

class Contract {
  int? id;
  String? accountId;
  int? scheduleTypeId;
  int? noteId;
  String? startDate;
  String? endDate;
  num? amount;
  String? name;
  Note? note;

  Contract({
    this.id,
    this.accountId,
    this.scheduleTypeId,
    this.noteId,
    this.startDate,
    this.endDate,
    this.amount,
    this.name,
    this.note,
  });

  Contract.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    scheduleTypeId = json['scheduleTypeId'];
    noteId = json['noteId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    amount = json['amount'];
    name = json['name'];
    note = json['note'] != null ? Note.fromJson(json['note']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountId'] = accountId;
    data['scheduleTypeId'] = scheduleTypeId;
    data['noteId'] = noteId;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['amount'] = amount;
    data['name'] = name;
    if (note != null) {
      data['note'] = note!.toJson();
    }
    return data;
  }
}
