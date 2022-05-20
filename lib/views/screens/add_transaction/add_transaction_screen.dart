import 'package:flutter/material.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/views/screens/add_transaction/add_transaction_body.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  static String routeName = '/add-transaction';

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    AddTransactionScreenArguments args = ModalRoute.of(context)!
        .settings
        .arguments as AddTransactionScreenArguments;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        title: const Text('Add a transaction', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: AddTransactionBody(tabIndex: args.tabIndex),
    );
  }
}

class AddTransactionScreenArguments {
  final int tabIndex;

  AddTransactionScreenArguments({required this.tabIndex});
}
