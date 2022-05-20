import 'package:flutter/material.dart';
import 'package:jars_mobile/constant.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String? subTxt;
  final Function? onPressed;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const TitleView({
    Key? key,
    required this.titleTxt,
    this.subTxt,
    this.onPressed,
    this.animationController,
    this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              30 * (1.0 - animation!.value),
              0.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      titleTxt,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        letterSpacing: 0.5,
                        color: kSecondaryColor,
                      ),
                    ),
                  ),
                  subTxt != null
                      ? InkWell(
                          highlightColor: Colors.transparent,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                          onTap: subTxt != null
                              ? onPressed as void Function()?
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                Text(
                                  subTxt!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                    color: jarsColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 38,
                                  width: 26,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
