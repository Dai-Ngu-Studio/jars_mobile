import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';

class TransactionHistoryBox extends StatelessWidget {
  const TransactionHistoryBox({
    Key? key,
    this.animationController,
    this.animation,
    required this.listTransaction,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;

  final List listTransaction;

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
              50 * (1.0 - animation!.value),
              0.0,
            ),
            child: Column(
              children: [
                ...listTransaction.map((transaction) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              transaction['jarImage'],
                              width: 30,
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaction['jarName'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: -0.2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  transaction['transactionNote'] != null
                                      ? Text(
                                          transaction['transactionNote'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            letterSpacing: -0.2,
                                            color: Colors.black38,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              NumberFormat.currency(
                                locale: 'vi_VN',
                                decimalDigits: 0,
                                symbol: 'đ',
                              ).format(transaction['amount']),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                letterSpacing: -0.2,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              transaction['transactionDate'],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.2,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),
                listTransaction.length >= 3
                    ? AdaptiveButton(
                        text: 'More',
                        enabled: true,
                        onPressed: () {},
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        );
      },
    );
  }
}
