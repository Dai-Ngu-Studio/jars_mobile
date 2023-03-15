import 'package:flutter/material.dart';
import 'package:jars_mobile/constants/colors.dart';
import 'package:jars_mobile/views/screens/general_settings/general_settings_body.dart';

class GeneralSettingsScreen extends StatelessWidget {
  const GeneralSettingsScreen({Key? key}) : super(key: key);

  static const String routeName = '/general-settings';

  @override
  Widget build(BuildContext context) {
    GeneralSettingsScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as GeneralSettingsScreenArguments;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('General Settings', style: TextStyle(fontSize: 16)),
      ),
      body: GeneralSettingsBody(animationController: args.animationController),
    );
  }
}

class GeneralSettingsScreenArguments {
  final AnimationController? animationController;

  const GeneralSettingsScreenArguments({this.animationController});
}
