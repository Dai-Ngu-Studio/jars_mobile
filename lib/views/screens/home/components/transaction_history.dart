import 'package:flutter/material.dart';
import 'package:jars_mobile/utils/utilities.dart';
import 'package:jars_mobile/views/screens/home/components/transaction_history_box.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({
    Key? key,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              30 * (1.0 - widget.animation!.value),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3 Latest Transactions'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TransactionHistoryBox(
                        animation: widget.animation!,
                        animationController: widget.animationController!,
                        listTransaction: [
                          {
                            'jarName': 'Investment',
                            'jarImage':
                                Utilities.getJarImageByName('Investment'),
                            'amount': 1200000,
                            'transactionDate': '12/12/2020',
                          },
                          {
                            'jarName': 'Give',
                            'jarImage': Utilities.getJarImageByName('Give'),
                            'amount': 600000,
                            'transactionDate': '12/12/2020',
                            'transactionNote': 'Tiền từ thiện',
                          },
                          {
                            'jarName': 'Investment',
                            'jarImage':
                                Utilities.getJarImageByName('Investment'),
                            'amount': 1200000,
                            'transactionDate': '12/12/2020',
                            'transactionNote': 'Đầu tư chứng khoán',
                          },
                        ],
                      ),
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
