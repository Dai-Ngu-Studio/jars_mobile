import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/constants/colors.dart';
import 'package:jars_mobile/views/screens/add_transaction/add_transaction_screen.dart';
import 'package:jars_mobile/views/widgets/curve_painter.dart';

class TotalIncomeExpenseBox extends StatelessWidget {
  const TotalIncomeExpenseBox({
    Key? key,
    required this.percentage,
    required this.degree,
    required this.balance,
    required this.income,
    required this.expense,
    this.animation,
  }) : super(key: key);

  final Animation? animation;

  final int percentage;
  final num degree;
  final int balance;
  final int income;
  final int expense;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 32),
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                          border: Border.all(width: 4, color: jarsColor.shade600.withOpacity(0.2)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              percentage == 0
                                  ? '0'
                                  : '${100 - (percentage * animation!.value).toInt()}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 24,
                                letterSpacing: 0.0,
                                color: jarsColor.shade600,
                              ),
                            ),
                            Text(
                              '%',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                letterSpacing: 0.0,
                                color: jarsColor.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CustomPaint(
                        painter: CurvePainter(
                          colors: [
                            jarsColor.shade700,
                            jarsColor.shade400,
                            jarsColor.shade100,
                          ],
                          angle: degree == 0
                              ? 0
                              : (360 - degree) + (360 - 252) * (1.0 - animation!.value),
                        ),
                        child: const SizedBox(width: 100, height: 100),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Balance', style: TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 12),
                Text(
                  NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(
                    (balance * animation!.value).toInt(),
                  ),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            )
          ],
        ),
        const Divider(height: 32, thickness: 1, indent: 16, endIndent: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AddTransactionScreen.routeName,
                  arguments: AddTransactionScreenArguments(tabIndex: 0),
                );
              },
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 50,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text('Income', style: TextStyle(color: Colors.grey, fontSize: 10)),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'vi_VN',
                            symbol: 'đ',
                          ).format((income * animation!.value).toInt()),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 4,
                    right: 8,
                    child: Icon(Icons.add, color: Colors.green, size: 16),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AddTransactionScreen.routeName,
                  arguments: AddTransactionScreenArguments(tabIndex: 1),
                );
              },
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 50,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text(
                            'Expense',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'vi_VN',
                            symbol: 'đ',
                          ).format((expense * animation!.value).toInt()),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 4,
                    right: 8,
                    child: Icon(Icons.remove, color: Colors.red, size: 16),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
