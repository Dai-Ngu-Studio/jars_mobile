import 'package:flutter/material.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/views/screens/update_bill/update_bill_body.dart';

class UpdateBillScreen extends StatefulWidget {
  const UpdateBillScreen({Key? key}) : super(key: key);

  static String routeName = "/update-bill";

  @override
  State<UpdateBillScreen> createState() => _UpdateBillScreenState();
}

class _UpdateBillScreenState extends State<UpdateBillScreen> {
  @override
  Widget build(BuildContext context) {
    UpdateBillScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as UpdateBillScreenArguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        title: const Text(
          'Update Bill Status',
          style: TextStyle(fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: UpdateBillBody(
        billId: args.billId,
      ),
    );
  }
}

class UpdateBillScreenArguments {
  final int billId;

  UpdateBillScreenArguments({
    required this.billId,
  });
}
