class ScheduleType {
  int? id;
  String? name;
  List<String>? contracts;

  ScheduleType({this.id, this.name, this.contracts});

  ScheduleType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contracts = json['contracts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['contracts'] = contracts;
    return data;
  }
}
