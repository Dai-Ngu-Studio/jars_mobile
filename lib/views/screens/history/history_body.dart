import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/data/models/transaction.dart';
import 'package:jars_mobile/data/remote/response/status.dart';
import 'package:jars_mobile/view_model/transaction_view_model.dart';
import 'package:jars_mobile/views/screens/transaction_details/transaction_details_screen.dart';
import 'package:jars_mobile/views/widgets/loading.dart';
import 'package:provider/provider.dart';

class HistoryBody extends StatefulWidget {
  const HistoryBody({Key? key, this.animationController}) : super(key: key);
  final AnimationController? animationController;

  @override
  State<HistoryBody> createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  final transactionVM = TransactionViewModel();
  final _firebaseAuth = FirebaseAuth.instance;

  List<Transactions> transactions = [];

  @override
  void initState() {
    super.initState();
    _firebaseAuth.currentUser!.getIdToken().then((idToken) {
      transactionVM.getTransactions(idToken: idToken).whenComplete(() {
        if (transactionVM.transactions.data == null) {
          return;
        }
        for (var transaction in transactionVM.transactions.data!) {
          var _transaction = Transactions(
            id: transaction.id,
            walletId: transaction.walletId,
            transactionDate: transaction.transactionDate,
            noteId: transaction.noteId,
            billId: transaction.billId,
            amount: transaction.amount,
          );
          transactions.add(_transaction);
        }
        transactions = transactions.reversed.toList();
      });
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Widget getHistoryViewUI() {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong! Please try again later."),
          );
        } else {
          return ChangeNotifierProvider<TransactionViewModel>(
              create: (BuildContext context) => transactionVM,
              child: Consumer<TransactionViewModel>(
                builder: (context, viewModel, _) {
                  switch (viewModel.transactions.status) {
                    case Status.LOADING:
                      return LoadingWidget();
                    case Status.ERROR:
                      return ErrorWidget(
                        viewModel.transactions.message ??
                            "Something went wrong.",
                      );
                    case Status.COMPLETED:
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];
                          var date = DateFormat("dd/MM/yyyy HH:mm").format(
                            DateTime.parse(transaction.transactionDate!)
                                .toLocal(),
                          );
                          var amount = NumberFormat.currency(
                            locale: 'vi_VN',
                            decimalDigits: 0,
                            symbol: 'đ',
                          ).format(transaction.amount);

                          return ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                TransactionDetails.routeName,
                                arguments: TransactionDetailsScreenArguments(
                                  transactionId: transaction.id!,
                                ),
                              );
                            },
                            title: Text(amount.toString()),
                            subtitle: Text(date),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: transactions.length,
                      );
                    default:
                  }
                  return const SizedBox.shrink();
                },
              ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kBackgroundColor,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              getHistoryViewUI(),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}
