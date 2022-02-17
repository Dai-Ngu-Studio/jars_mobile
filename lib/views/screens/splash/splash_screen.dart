import 'package:flutter/material.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/views/screens/login/init_widget.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _splashScreen();
  }

  _splashScreen() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: const InitializerWidget(),
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2E3BBA), Color(0xFF5973DD)],
                stops: [0, 100],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Hero(
              tag: 'SplashScreen',
              child: Assets.images.jarsLogo.image(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                // width: MediaQuery.of(context).size.width * 0.3,
                width: 128,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
