import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/data/local/app_shared_preference.dart';
import 'package:jars_mobile/views/screens/app/app.dart';
import 'package:jars_mobile/views/screens/intro/intro_screen.dart';
import 'package:jars_mobile/views/screens/login/login_screen.dart';

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  FirebaseAuth? _auth;
  User? _user;
  final _prefs = AppSharedPreference();

  bool? _skipIntro;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth?.currentUser;
    _isSkipIntro();
  }

  Future _isSkipIntro() {
    return _prefs
        .getBool(key: "isSkipIntro")
        .then((value) => setState(() => _skipIntro = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _skipIntro ?? false
          ? _user != null
              ? const JarsApp()
              : const LoginScreen()
          : const IntroScreen(),
    );
  }
}
