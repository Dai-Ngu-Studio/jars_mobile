import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jars_mobile/views/widgets/touchspin_widget.dart';

class JarsPercentageBox extends StatelessWidget {
  const JarsPercentageBox({
    Key? key,
    this.animationController,
    this.animation,
    required this.controller,
    required this.jarImage,
    required this.jarName,
    required this.onChanged,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;
  final TextEditingController controller;
  final String jarImage;
  final String jarName;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            jarImage,
                            width: MediaQuery.of(context).size.width < 350 ? 25 : 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            jarName,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width < 350 ? 12 : 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      TouchSpinWidget(
                        min: 0,
                        max: 100,
                        steps: 5,
                        controller: controller,
                        onChanged: (value) {
                          controller.text = value.text.toString();
                          onChanged();
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(indent: 24, endIndent: 24, thickness: 1),
              ],
            ),
          ),
        );
      },
    );
  }
}
