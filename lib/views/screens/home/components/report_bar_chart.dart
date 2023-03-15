import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/utils/utilities.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';

class ReportBarChart extends StatefulWidget {
  const ReportBarChart({Key? key, required this.transactionList}) : super(key: key);

  final List transactionList;

  @override
  State<StatefulWidget> createState() => ReportBarChartState();
}

class ReportBarChartState extends State<ReportBarChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "From week ${(Utilities.getWeekNumberOfYear(DateTime.now()) - 4)} to ${Utilities.getWeekNumberOfYear(DateTime.now())} 2022",
          style: const TextStyle(fontSize: 12, color: Colors.black38, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 12,
                    child: DChartBar(
                      data: [
                        {
                          'id': 'income',
                          'data': [
                            {'domain': 'Week 1', 'measure': 320000},
                            {'domain': 'Week 2', 'measure': 100000},
                            {'domain': 'Week 3', 'measure': 700000},
                            {'domain': 'Week 4', 'measure': 620000},
                          ],
                        },
                        {
                          'id': 'expense',
                          'data': [
                            {'domain': 'Week 1', 'measure': 110000},
                            {'domain': 'Week 2', 'measure': 300000},
                            {'domain': 'Week 3', 'measure': 50000},
                            {'domain': 'Week 4', 'measure': 480000},
                          ],
                        },
                      ],
                      minimumPaddingBetweenLabel: 2,
                      domainLabelPaddingToAxisLine: 16,
                      measureLabelFontSize: 10,
                      axisLineTick: 2,
                      axisLinePointTick: 2,
                      axisLinePointWidth: 10,
                      axisLineColor: Colors.grey,
                      measureLabelPaddingToAxisLine: 16,
                      barColor: (barData, index, id) {
                        return id == 'income' ? Colors.greenAccent : Colors.redAccent;
                      },
                      barValue: (barData, index) {
                        return NumberFormat.compact().format(
                          barData['measure'],
                        );
                      },
                      showBarValue: true,
                      barValueFontSize: 10,
                      barValuePosition: BarValuePosition.outside,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AdaptiveButton(
          text: 'More',
          enabled: true,
          onPressed: () {},
        )
      ],
    );
  }
}
