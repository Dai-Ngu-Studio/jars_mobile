import 'package:flutter/material.dart';
import 'package:jars_mobile/data/local/shared_prefs_helper.dart';
import 'package:jars_mobile/view_model/account_view_model.dart';
import 'package:jars_mobile/views/screens/app/app.dart';
import 'package:jars_mobile/views/screens/intro/intro_screen.dart';
import 'package:jars_mobile/views/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  @override
  State<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  bool? _skipIntro;

  @override
  void initState() {
    _isSkipIntro();
    super.initState();
  }

  Future _isSkipIntro() async {
    return await SharedPrefsHelper.getString(key: "isSkipIntro").then((value) {
      setState(() => _skipIntro = (value == 'true'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _skipIntro ?? true
          ? Selector<AccountViewModel, bool>(
              selector: (context, accountVM) => accountVM.isAuth,
              builder: (context, isAuth, _) => isAuth ? const JarsApp() : const LoginScreen(),
            )
          : const IntroScreen(),
    );
  }
}
