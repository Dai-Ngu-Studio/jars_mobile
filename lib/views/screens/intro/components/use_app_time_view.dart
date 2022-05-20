import 'package:flutter/material.dart';
import 'package:jars_mobile/gen/assets.gen.dart';

class UseAppTimeView extends StatelessWidget {
  final AnimationController animationController;

  const UseAppTimeView({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.2, curve: Curves.fastOutSlowIn),
      ),
    );
    final _secondHalfAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-1, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.4, curve: Curves.fastOutSlowIn),
      ),
    );
    final _textAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-2, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.4, curve: Curves.fastOutSlowIn),
      ),
    );
    final _imageAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-4, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.4, curve: Curves.fastOutSlowIn),
      ),
    );

    final _titleAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.2, curve: Curves.fastOutSlowIn),
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
                position: _titleAnimation,
                child: const FittedBox(
                  child: Text(
                    "Just 2 minutes a day!",
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _textAnimation,
                child: const FittedBox(
                  child: Text(
                    "Using JARS to make your spending habit well-planned",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SlideTransition(
                position: _imageAnimation,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 350,
                    maxHeight: 250,
                  ),
                  child: Assets.svgs.useAppTime.svg(
                    width: MediaQuery.of(context).size.width < 350
                        ? 200
                        : MediaQuery.of(context).size.width,
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
