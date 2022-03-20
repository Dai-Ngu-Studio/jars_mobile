import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/views/add_transaction/add_transaction_screen.dart';
import 'package:jars_mobile/views/widgets/curve_painter.dart';

class TotalIncomeExpense extends StatelessWidget {
  const TotalIncomeExpense({
    Key? key,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;

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
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16,
                bottom: 18,
              ),
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
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
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
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                        border: Border.all(
                                          width: 4,
                                          color: jarsColor.shade600
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${(70 * animation!.value).toInt()}',
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
                                        angle: 252 +
                                            (360 - 252) *
                                                (1.0 - animation!.value),
                                      ),
                                      child: const SizedBox(
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Balance',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                NumberFormat.currency(
                                  locale: 'vi_VN',
                                  symbol: 'đ',
                                ).format((8400000 * animation!.value).toInt()),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const Divider(
                        height: 32,
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AddTransactionScreen.routeName,
                                arguments: AddTransactionScreenArguments(
                                  tabIndex: 0,
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      50,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 2.0),
                                        child: Text(
                                          'Income',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                        ).format((12000000 * animation!.value)
                                            .toInt()),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Positioned(
                                  top: 4,
                                  right: 8,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AddTransactionScreen.routeName,
                                arguments: AddTransactionScreenArguments(
                                  tabIndex: 1,
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      50,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 2.0),
                                        child: Text(
                                          'Expense',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'vi_VN',
                                          symbol: 'đ',
                                        ).format((3600000 * animation!.value)
                                            .toInt()),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Positioned(
                                  top: 4,
                                  right: 8,
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
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
