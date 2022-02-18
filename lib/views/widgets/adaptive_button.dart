import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  const AdaptiveButton({
    Key? key,
    this.height,
    this.widthWeb,
    this.widthMobile,
    required this.text,
    this.textColor,
    this.backgroundColor,
    required this.enabled,
    this.textStyle,
    this.borderRadius,
    this.onPressed,
    this.isLoading,
    this.icon,
  }) : super(key: key);

  final double? height;
  final double? widthWeb, widthMobile;
  final String text;
  final TextStyle? textStyle;
  final Color? textColor, backgroundColor;
  final Widget? icon;
  final bool enabled;
  final double? borderRadius;
  final Function? onPressed;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: kIsWeb
              ? widthWeb ?? double.infinity
              : widthMobile ?? double.infinity,
          height: height ?? 35,
          child: Material(
            color: backgroundColor ?? Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
            child: InkWell(
              onTap: enabled ? onPressed as void Function()? : null,
              splashColor: Colors.white.withOpacity(.3),
              radius: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: icon,
                        )
                      : const SizedBox.shrink(),
                  Text(
                    text,
                    style: textStyle ??
                        TextStyle(
                          fontSize: 14,
                          color: textColor ?? Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isLoading ?? false
            ? Opacity(
                opacity: 0.5,
                child: Container(
                  height: height ?? 40,
                  width: kIsWeb
                      ? widthWeb ?? double.infinity
                      : widthMobile ?? double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(borderRadius ?? 20),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.grey),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
