import 'package:flutter/material.dart';
import 'package:jars_mobile/constants/colors.dart';
import 'package:jars_mobile/views/screens/bill_details/bill_details_body.dart';

class BillDetailsScreen extends StatelessWidget {
  const BillDetailsScreen({Key? key}) : super(key: key);

  static const String routeName = '/bill-details';

  @override
  Widget build(BuildContext context) {
    BillDetailsScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as BillDetailsScreenArguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        title: const Text('Bill Details', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BillDetailsBody(billId: args.billId),
    );
  }
}

class BillDetailsScreenArguments {
  final int billId;

  BillDetailsScreenArguments({required this.billId});
}
