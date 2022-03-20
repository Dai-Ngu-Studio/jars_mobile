import 'package:flutter/material.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/views/add_transaction/add_transaction_body.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  static String routeName = '/add-transaction';

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  //   with SingleTickerProviderStateMixin {
  // late final TabController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = TabController(length: 3, vsync: this, initialIndex: 1);
  // }

  @override
  Widget build(BuildContext context) {
    // AddTransactionScreenArguments args = ModalRoute.of(context)!
    //     .settings
    //     .arguments as AddTransactionScreenArguments;

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
      body: const AddTransactionBody(),
    );
  }
}
