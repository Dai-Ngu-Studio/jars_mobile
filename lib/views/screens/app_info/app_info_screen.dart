import 'package:flutter/material.dart';
import 'package:jars_mobile/views/screens/app_info/app_info_body.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({Key? key}) : super(key: key);

  static String routeName = '/app-info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('App Infomation', style: TextStyle(fontSize: 16)),
      ),
      body: const AppInfoBody(),
    );
  }
}
