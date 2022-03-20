class ScheduleType {
  int? id;
  String? name;

  ScheduleType({this.id, this.name});

  ScheduleType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

// ignore_for_file: constant_identifier_names
enum ScheduleTypeEnum { NONE, DAILY, WEEKLY, MONTHLY }
