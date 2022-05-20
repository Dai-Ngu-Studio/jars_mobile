import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/gen/assets.gen.dart';

class WelcomeView extends StatelessWidget {
  final AnimationController animationController;
  const WelcomeView({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 0.8, curve: Curves.fastOutSlowIn),
      ),
    );
    final _secondHalfAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-1, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    final _welcomeFirstHalfAnimation = Tween<Offset>(
      begin: const Offset(2, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 0.8, curve: Curves.fastOutSlowIn),
      ),
    );

    final _welcomeImageAnimation = Tween<Offset>(
      begin: const Offset(4, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 0.8, curve: Curves.fastOutSlowIn),
      ),
    );
    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(bottom: 100, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _welcomeImageAnimation,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 350,
                    maxHeight: 350,
                  ),
                  child: Assets.images.jarsLogo.image(
                    width:
                        kIsWeb ? 200 : MediaQuery.of(context).size.width * 0.25,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SlideTransition(
                position: _welcomeFirstHalfAnimation,
                child: const Text(
                  "Welcome to JARS",
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const FittedBox(
                child: Text(
                  "Get on top of your money, achieve financial goals.\nEnjoy wonderful life and become financially independent.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
