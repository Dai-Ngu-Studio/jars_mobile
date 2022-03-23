import 'package:flutter/material.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/views/screens/create_bill_details/create_bill_body.dart';

class CreateBillDetailsScreen extends StatelessWidget {
  const CreateBillDetailsScreen({Key? key}) : super(key: key);

  static String routeName = '/create-bill-details';

  @override
  Widget build(BuildContext context) {
    CreateBillDetailsScreenArguments args = ModalRoute.of(context)!
        .settings
        .arguments as CreateBillDetailsScreenArguments;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        title: const Text(
          'Create Bills Details',
          style: TextStyle(fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: CreateBillDetailsBody(onPressed: args.onPressed),
    );
  }
}

class CreateBillDetailsScreenArguments {
  final Function onPressed;

  CreateBillDetailsScreenArguments({required this.onPressed});
}
