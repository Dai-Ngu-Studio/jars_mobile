import 'package:flutter/material.dart';
import 'package:jars_mobile/views/screens/bill/components/bill_box.dart';

class BillBody extends StatefulWidget {
  const BillBody({Key? key}) : super(key: key);

  @override
  State<BillBody> createState() => _BillBodyState();
}

class _BillBodyState extends State<BillBody> {
  List listData = [];
  @override
  void initState() {
    listData = [
      {
        "id": 1,
        "name": "tiền nhà",
        "date": "2020-01-01",
        "leftAmount": 100,
        "amount": 200,
      },
      {
        "id": 1,
        "name": "tiền học",
        "date": "2020-01-01",
        "leftAmount": 100,
        "amount": 200,
      },
      {
        "id": 1,
        "name": "tiền wifi",
        "date": "2020-01-01",
        "leftAmount": 100,
        "amount": 200,
      },
      {
        "id": 1,
        "name": "tiền tập gym",
        "date": "2020-01-01",
        "leftAmount": 100,
        "amount": 200,
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, index) {
        return BillBox(
          billId: listData[index]['id'],
          name: listData[index]['name'],
          date: listData[index]['date'],
          leftAmount: listData[index]['leftAmount'],
          amount: listData[index]['amount'],
        );
      },
    );
  }
}
