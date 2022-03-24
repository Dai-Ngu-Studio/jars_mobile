import 'package:flutter/material.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/views/screens/create_bill/create_bill_body.dart';

class CreateBillScreen extends StatelessWidget {
  const CreateBillScreen({Key? key}) : super(key: key);

  static String routeName = '/create-bill';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        title: const Text('Create Bill', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const CreateBillBody(),
    );
  }
}
