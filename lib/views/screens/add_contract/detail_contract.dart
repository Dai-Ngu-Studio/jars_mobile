import 'package:flutter/material.dart';
import 'package:jars_mobile/constants/colors.dart';
import 'package:jars_mobile/views/screens/add_contract/components/contract_detail_body.dart';

class DetailContractScreen extends StatelessWidget {
  const DetailContractScreen({Key? key}) : super(key: key);

  static const String routeName = '/detail-contract';

  @override
  Widget build(BuildContext context) {
    DetailContractScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as DetailContractScreenArguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        title: const Text('Contract Detail', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: DetailContractBody(contractId: args.contractID),
    );
  }
}

class DetailContractScreenArguments {
  final int contractID;

  DetailContractScreenArguments({required this.contractID});
}
