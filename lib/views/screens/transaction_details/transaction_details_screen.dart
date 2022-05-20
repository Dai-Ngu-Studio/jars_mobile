import 'package:flutter/material.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/views/screens/transaction_details/transaction_details_body.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({Key? key}) : super(key: key);

  static String routeName = "/transaction-details";

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  @override
  Widget build(BuildContext context) {
    TransactionDetailsScreenArguments args = ModalRoute.of(context)!
        .settings
        .arguments as TransactionDetailsScreenArguments;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        title:
            const Text('Transaction Details', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: TransactionDetailsBody(transactionId: args.transactionId),
    );
  }
}

class TransactionDetailsScreenArguments {
  final int transactionId;

  TransactionDetailsScreenArguments({required this.transactionId});
}
