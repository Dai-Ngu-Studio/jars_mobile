import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/data/models/transaction.dart';
import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/utils/utilities.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';

class TransactionHistoryBox extends StatelessWidget {
  const TransactionHistoryBox({
    Key? key,
    this.animationController,
    this.animation,
    required this.transaction,
    required this.walletVM,
    required this.index,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;

  final Transactions transaction;
  final WalletViewModel walletVM;
  final int index;

  @override
  Widget build(BuildContext context) {
    final amount = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
      decimalDigits: 0,
    ).format(transaction.amount);

    return index < 3
        ? AnimatedBuilder(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Utilities.getJarImageByName(
                                    getJarNameByJarId(
                                        jarID: transaction.walletId!)!,
                                  ),
                                  width: 30,
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getJarNameByJarId(
                                            jarID: transaction.walletId!)!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: -0.2,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // const SizedBox(height: 4),
                                      // transaction.noteId != null
                                      //     ? Text(
                                      //         transaction.noteId.toString(),
                                      //         style: const TextStyle(
                                      //           fontWeight: FontWeight.w500,
                                      //           fontSize: 12,
                                      //           letterSpacing: -0.2,
                                      //           color: Colors.black38,
                                      //         ),
                                      //       )
                                      //     : const SizedBox.shrink(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  transaction.amount!.isNegative
                                      ? amount
                                      : "+$amount",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    letterSpacing: -0.2,
                                    color: transaction.amount!.isNegative
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(transaction.transactionDate!)
                                        .toLocal(),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.2,
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : const SizedBox.shrink();
  }

  String? getJarNameByJarId({required int jarID}) {
    for (Wallet element in walletVM.wallet.data!) {
      if (element.id == jarID) return element.name!;
    }
    return null;
  }
}
