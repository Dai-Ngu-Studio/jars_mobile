import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DonutChartBadge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;
  final String title;
  final String text;

  const DonutChartBadge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showBottomSheet(context: context),
      child: AnimatedContainer(
        duration: PieChart.defaultDuration,
        width: MediaQuery.of(context).size.width < 350 ? size * 0.8 : size,
        height: MediaQuery.of(context).size.width < 350 ? size * 0.8 : size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.5),
              offset: const Offset(3, 3),
              blurRadius: 3,
            ),
          ],
        ),
        padding: EdgeInsets.all(size * .15),
        child: Center(child: SvgPicture.asset(svgAsset, fit: BoxFit.contain)),
      ),
    );
  }

  void showBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(.2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (() => Navigator.of(context).pop()),
                  icon: const Icon(Icons.close, color: Colors.black),
                  splashRadius: 20,
                ),
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Padding(padding: EdgeInsets.only(right: 48)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Text(text, style: const TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ],
        );
      },
    );
  }
}
