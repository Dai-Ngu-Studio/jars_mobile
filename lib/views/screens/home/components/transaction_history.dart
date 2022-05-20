import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/data/models/transaction.dart';
import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/data/remote/response/status.dart';
import 'package:jars_mobile/utils/utilities.dart';
import 'package:jars_mobile/view_model/transaction_view_model.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/screens/home/components/transaction_history_box.dart';
import 'package:jars_mobile/views/screens/transaction_details/transaction_details_screen.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';
import 'package:jars_mobile/views/widgets/loading.dart';
import 'package:provider/provider.dart';

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
  final _transactionVM = TransactionViewModel();
  final _walletVM = WalletViewModel();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    _firebaseAuth.currentUser!.getIdToken().then((idToken) async {
      await _walletVM.getWallet(idToken: idToken);

      _firebaseAuth.currentUser!.getIdToken().then((idToken) {
        _transactionVM.getTransactions(idToken: idToken);
      });
    });
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
                      ChangeNotifierProvider<TransactionViewModel>(
                        create: (BuildContext context) => _transactionVM,
                        child: Consumer<TransactionViewModel>(
                          builder: (context, viewModel, _) {
                            if (viewModel.transactions.data?.isEmpty ?? true) {
                              return const Text("No transactions yet.");
                            }
                            viewModel.transactions.data?.sort(
                              (a, b) => b.transactionDate.compareTo(
                                a.transactionDate,
                              ),
                            );

                            switch (viewModel.transactions.status) {
                              case Status.LOADING:
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LoadingWidget(),
                                );
                              case Status.ERROR:
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ErrorWidget(
                                    viewModel.transactions.message ??
                                        "Something went wrong.",
                                  ),
                                );
                              case Status.COMPLETED:
                                return Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      addAutomaticKeepAlives: false,
                                      itemCount: 4,
                                      itemBuilder: (context, index) {
                                        final Transactions transaction =
                                            viewModel.transactions.data![index];
                                        return TransactionHistoryBox(
                                          animation: widget.animation,
                                          animationController:
                                              widget.animationController,
                                          transaction: transaction,
                                          walletVM: _walletVM,
                                          index: index,
                                        );
                                      },
                                    ),
                                    // const SizedBox(height: 8),
                                    // AdaptiveButton(
                                    //   text: 'More',
                                    //   enabled: true,
                                    //   onPressed: () {},
                                    // )
                                  ],
                                );
                              default:
                            }
                            return const SizedBox.shrink();
                          },
                        ),
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

  String? getJarNameByJarId({required int jarID}) {
    for (Wallet element in _walletVM.wallet.data!) {
      if (element.id == jarID) return element.name!;
    }
    return null;
  }
}
