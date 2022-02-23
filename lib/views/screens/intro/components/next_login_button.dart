import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';

class CenterNextButton extends StatefulWidget {
  final AnimationController animationController;
  final VoidCallback onNextClick;
  final bool isLoading;

  const CenterNextButton({
    Key? key,
    required this.animationController,
    required this.onNextClick,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<CenterNextButton> createState() => _CenterNextButtonState();
}

class _CenterNextButtonState extends State<CenterNextButton> {
  @override
  Widget build(BuildContext context) {
    final _topMoveAnimation = Tween<Offset>(
      begin: const Offset(0, 5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.0, 0.2, curve: Curves.fastOutSlowIn),
      ),
    );
    final _signUpMoveAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.6, 0.8, curve: Curves.fastOutSlowIn),
      ),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: 16 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: _topMoveAnimation,
            child: AnimatedBuilder(
              animation: widget.animationController,
              builder: (context, child) => AnimatedOpacity(
                opacity: widget.animationController.value >= 0.2 &&
                        widget.animationController.value <= 0.6
                    ? 1
                    : 0,
                duration: const Duration(milliseconds: 480),
                child: _pageView(),
              ),
            ),
          ),
          SlideTransition(
            position: _topMoveAnimation,
            child: AnimatedBuilder(
              animation: widget.animationController,
              builder: (context, child) => Padding(
                padding: EdgeInsets.only(
                  bottom: 38 - (38 * _signUpMoveAnimation.value),
                ),
                child: Container(
                  height: 58,
                  width: MediaQuery.of(context).size.width < 800
                      ? 58 +
                          MediaQuery.of(context).size.width *
                              0.8 *
                              _signUpMoveAnimation.value
                      : 58 +
                          MediaQuery.of(context).size.width *
                              0.5 *
                              _signUpMoveAnimation.value,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 480),
                    reverse: _signUpMoveAnimation.value < 0.7,
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                    ) {
                      return SharedAxisTransition(
                        fillColor: Colors.transparent,
                        child: child,
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.vertical,
                      );
                    },
                    child: _signUpMoveAnimation.value > 0.7
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AdaptiveButton(
                              text: "Login with Google",
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              icon: Assets.svgs.google.svg(height: 30),
                              enabled: !widget.isLoading,
                              backgroundColor: Colors.transparent,
                              height: double.infinity,
                              widthWeb: double.infinity,
                              widthMobile: double.infinity,
                              onPressed: widget.isLoading
                                  ? null
                                  : () => widget.onNextClick(),
                              isLoading: widget.isLoading,
                            ),
                          )
                        : InkWell(
                            key: const ValueKey('next button'),
                            onTap: widget.onNextClick,
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageView() {
    int _selectedIndex = 0;

    if (widget.animationController.value >= 0.7) {
      _selectedIndex = 3;
    } else if (widget.animationController.value >= 0.5) {
      _selectedIndex = 2;
    } else if (widget.animationController.value >= 0.3) {
      _selectedIndex = 1;
    } else if (widget.animationController.value >= 0.1) {
      _selectedIndex = 0;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < 4; i++)
            Padding(
              padding: const EdgeInsets.all(4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 480),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: _selectedIndex == i
                      ? const Color(0xff132137)
                      : const Color(0xffE3E4E4),
                ),
                width: 10,
                height: 10,
              ),
            )
        ],
      ),
    );
  }
}
