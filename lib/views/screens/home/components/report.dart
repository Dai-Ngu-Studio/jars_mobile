import 'package:flutter/material.dart';
import 'package:jars_mobile/views/screens/home/components/report_bar_chart.dart';

class Report extends StatefulWidget {
  const Report({Key? key, this.animationController, this.animation}) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List weeklyTransaction = [];

  @override
  void initState() {
    weeklyTransaction = [
      {
        'transactionDate': '2020-01-01',
        'wallet': 'Necessities',
        'amount': '1000000',
      },
      {
        'transactionDate': '2020-01-02',
        'wallet': 'Necessities',
        'amount': '200000',
      },
      {
        'transactionDate': '2020-01-03',
        'wallet': 'Necessities',
        'amount': '3000000',
      },
      {
        'transactionDate': '2020-06-04',
        'wallet': 'Education',
        'amount': '-10000000',
      },
      {
        'transactionDate': '2020-07-05',
        'wallet': 'Necessities',
        'amount': '800000',
      },
      {
        'transactionDate': '2020-07-06',
        'wallet': 'Saving',
        'amount': '460000',
      },
      {
        'transactionDate': '2020-12-07',
        'wallet': 'Saving',
        'amount': '-100000',
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 36, bottom: 16),
                      child: ReportBarChart(transactionList: weeklyTransaction),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
