import 'package:flutter/material.dart';
import 'package:jars_mobile/views/screens/bill_details/components/bill_details_box.dart';

class BillDetailsBody extends StatefulWidget {
  const BillDetailsBody({Key? key, required this.billId}) : super(key: key);

  final int billId;

  @override
  State<BillDetailsBody> createState() => _BillDetailsBodyState();
}

class _BillDetailsBodyState extends State<BillDetailsBody> {
  List listBillDetails = [];

  @override
  void initState() {
    listBillDetails = [
      {
        "itemName": "pizza",
        "price": 120000,
        "quantity": 2,
      },
      {
        "itemName": "snack",
        "price": 5000,
        "quantity": 10,
      },
      {
        "itemName": "coca",
        "price": 8000,
        "quantity": 4,
      },
      {
        "itemName": "pepsi",
        "price": 7000,
        "quantity": 2,
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.2,
        ),
        itemCount: listBillDetails.length,
        itemBuilder: (context, index) {
          return BillDetailsBox(
            name: listBillDetails[index]['itemName'],
            quantity: listBillDetails[index]['quantity'],
            price: listBillDetails[index]['price'],
          );
        },
      ),
    );
  }
}
