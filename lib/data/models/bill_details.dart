class BillDetails {
  int? id;
  String? itemName;
  int? price;
  int? quantity;
  int? billId;

  BillDetails({this.id, this.itemName, this.price, this.quantity, this.billId});

  BillDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['itemName'];
    price = json['price'];
    quantity = json['quantity'];
    billId = json['billId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['itemName'] = itemName;
    data['price'] = price;
    data['quantity'] = quantity;
    data['billId'] = billId;
    return data;
  }
}
