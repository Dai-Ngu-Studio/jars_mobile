import 'package:flutter/material.dart';

class BackSkipWidget extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onBackClick;
  final VoidCallback onSkipClick;

  const BackSkipWidget({
    Key? key,
    required this.onBackClick,
    required this.onSkipClick,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.2, curve: Curves.fastOutSlowIn),
      ),
    );

    final _skipAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(2, 0),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.6, 0.8, curve: Curves.fastOutSlowIn),
      ),
    );

    return SlideTransition(
      position: _animation,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SizedBox(
          height: 58,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onBackClick,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: Colors.white,
                ),
                SlideTransition(
                  position: _skipAnimation,
                  child: IconButton(
                    onPressed: onSkipClick,
                    padding: const EdgeInsets.only(right: 8),
                    icon: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
