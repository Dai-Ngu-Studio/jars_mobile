import 'package:flutter/material.dart';
import 'package:jars_mobile/gen/assets.gen.dart';

class SixJarsPrincipleView extends StatelessWidget {
  final AnimationController animationController;

  const SixJarsPrincipleView({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.4, curve: Curves.fastOutSlowIn),
      ),
    );
    final _secondHalfAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-1, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.4, 0.6, curve: Curves.fastOutSlowIn),
      ),
    );
    final _relaxFirstHalfAnimation = Tween<Offset>(
      begin: const Offset(2, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.4, curve: Curves.fastOutSlowIn),
      ),
    );
    final _relaxSecondHalfAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-2, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.4, 0.6, curve: Curves.fastOutSlowIn),
      ),
    );

    final _imageFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.4, curve: Curves.fastOutSlowIn),
      ),
    );
    final _imageSecondHalfAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-4, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.4, 0.6, curve: Curves.fastOutSlowIn),
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
                position: _imageFirstHalfAnimation,
                child: SlideTransition(
                  position: _imageSecondHalfAnimation,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                      maxHeight: 300,
                    ),
                    child: Assets.svgs.sixJarsPrinciple.svg(
                      width: MediaQuery.of(context).size.width < 350
                          ? 180
                          : MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SlideTransition(
                position: _relaxFirstHalfAnimation,
                child: SlideTransition(
                  position: _relaxSecondHalfAnimation,
                  child: const FittedBox(
                    child: Text(
                      "The 6 Jars Principle",
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const FittedBox(
                child: Text(
                  "Allocate your income into 6 jars for different purposes.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
