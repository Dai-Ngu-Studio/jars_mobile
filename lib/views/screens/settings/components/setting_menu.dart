import 'package:flutter/material.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu({
    Key? key,
    required this.text,
    this.onPressed,
    this.icon,
    this.animationController,
    this.animation,
    this.iconNext,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;

  final Widget? icon;
  final String text;
  final VoidCallback? onPressed;
  final bool? iconNext;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
              child: Material(
                child: InkWell(
                  onTap: onPressed,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.1),
                          offset: const Offset(0, 1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            icon ?? const SizedBox.shrink(),
                            const SizedBox(width: 10),
                            Text(
                              text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        iconNext ?? true
                            ? const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20)
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
