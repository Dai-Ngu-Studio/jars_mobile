import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/data/remote/response/status.dart';
import 'package:jars_mobile/view_model/transaction_view_model.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/screens/home/components/total_income_expense_box.dart';
import 'package:jars_mobile/views/widgets/loading.dart';
import 'package:provider/provider.dart';

class TotalIncomeExpense extends StatefulWidget {
  const TotalIncomeExpense({
    Key? key,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<TotalIncomeExpense> createState() => _TotalIncomeExpenseState();
}

class _TotalIncomeExpenseState extends State<TotalIncomeExpense> {
  final _walletVM = WalletViewModel();
  final _transactionVM = TransactionViewModel();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    _firebaseAuth.currentUser!.getIdToken().then((idToken) {
      _walletVM.getWallet(idToken: idToken);
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
                  child: ChangeNotifierProvider(
                    create: (context) => _walletVM,
                    child: Consumer<WalletViewModel>(
                      builder: ((context, walletVM, _) {
                        switch (walletVM.wallet.status) {
                          case Status.LOADING:
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 62.0,
                              ),
                              child: LoadingWidget(),
                            );
                          case Status.ERROR:
                            return ErrorWidget(
                              walletVM.wallet.message ?? "Something went wrong",
                            );
                          case Status.COMPLETED:
                            final int balance = walletVM.wallet.data!.fold(0,
                                (previousValue, element) {
                              return previousValue +
                                  (element as Wallet).amountLeft!.toInt();
                            });
                            final int income = walletVM.wallet.data!.fold(0,
                                (previousValue, element) {
                              return previousValue +
                                  (element as Wallet).totalAdded!.toInt();
                            });
                            final int expense = walletVM.wallet.data!.fold(0,
                                (previousValue, element) {
                              return previousValue +
                                  (element as Wallet).totalSpend!.toInt();
                            });
                            final int percentage;

                            if (income == 0) {
                              percentage = 0;
                            } else if (expense == 0) {
                              percentage = 100;
                            } else {
                              percentage = (expense / income * 100).toInt();
                            }

                            final degree = percentage * 3.6;

                            return TotalIncomeExpenseBox(
                              percentage: percentage,
                              balance: balance,
                              income: income,
                              expense: expense,
                              degree: degree,
                              animation: widget.animation,
                            );
                          default:
                        }
                        return const SizedBox.shrink();
                      }),
                    ),
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
