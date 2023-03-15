import 'package:flutter/material.dart';
import 'package:jars_mobile/constants/colors.dart';
import 'package:jars_mobile/views/screens/factory_reset/factory_reset_body.dart';

class FactoryResetScreen extends StatelessWidget {
  const FactoryResetScreen({Key? key}) : super(key: key);

  static const String routeName = '/factory-reset';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Factory Reset', style: TextStyle(fontSize: 16)),
      ),
      body: const FactoryResetBody(),
    );
  }
}
