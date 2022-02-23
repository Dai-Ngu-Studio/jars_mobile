import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/data/local/app_shared_preference.dart';
import 'package:jars_mobile/service/firebase/auth_service.dart';
import 'package:jars_mobile/view_model/account_view_model.dart';
import 'package:jars_mobile/views/screens/home/home_screen.dart';
import 'package:jars_mobile/views/screens/intro/components/auto_split_view.dart';
import 'package:jars_mobile/views/screens/intro/components/back_skip_widget.dart';
import 'package:jars_mobile/views/screens/intro/components/begin_view.dart';
import 'package:jars_mobile/views/screens/intro/components/next_login_button.dart';
import 'package:jars_mobile/views/screens/intro/components/six_jars_principle_view.dart';
import 'package:jars_mobile/views/screens/intro/components/use_app_time_view.dart';
import 'package:jars_mobile/views/screens/intro/components/welcome_view.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  late AnimationController? _animationController;
  final AuthService _googleSignIn = AuthService();
  final _prefs = AppSharedPreference();
  final accountViewModel = AccountViewModel();
  String? fcmToken;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    _animationController?.animateTo(0.0);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: jarsColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E3BBA), Color(0xFF5973DD)],
            stops: [0, 100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ClipRect(
          child: Stack(
            children: [
              BeginScreen(
                animationController: _animationController!,
              ),
              UseAppTimeView(
                animationController: _animationController!,
              ),
              SixJarsPrincipleView(
                animationController: _animationController!,
              ),
              AutoSplitView(
                animationController: _animationController!,
              ),
              WelcomeView(
                animationController: _animationController!,
              ),
              BackSkipWidget(
                onBackClick: _onBackClick,
                onSkipClick: _onSkipClick,
                animationController: _animationController!,
              ),
              CenterNextButton(
                animationController: _animationController!,
                onNextClick: _onNextClick,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(
      0.8,
      duration: const Duration(milliseconds: 1200),
    );
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _login();
    }
  }

  void _login() {
    final _firebaseAuth = FirebaseAuth.instance;

    setState(() => isLoading = true);

    _googleSignIn.googleLogin().whenComplete(() {
      if (_firebaseAuth.currentUser != null) {
        _prefs.setBool(key: "isSkipIntro", value: true);
        _firebaseAuth.currentUser!.getIdToken().then((idToken) {
          getFCMToken().then((value) {
            accountViewModel.login(
              idToken: idToken,
              fcmToken: fcmToken,
            );
          });

          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }).catchError((error) {
          log(error.toString());
        });
      }
    }).catchError(
      (error) {
        final snackBar = SnackBar(
          content: Text(error.toString()),
          duration: const Duration(seconds: 5),
        );
        log(error.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      },
    ).then((_) => setState(() => isLoading = false));
  }

  Future<String?> getFCMToken() async {
    await FirebaseMessaging.instance
        .getToken()
        .then((value) => setState(() => fcmToken = value!));
    print("LoginScreen Body :: FCM Token: $fcmToken");
    return fcmToken;
  }
}
