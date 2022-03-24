import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/data/models/transaction.dart';
import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/data/remote/response/status.dart';
import 'package:jars_mobile/utils/utilities.dart';
import 'package:jars_mobile/view_model/transaction_view_model.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/screens/transaction_details/transaction_details_screen.dart';
import 'package:jars_mobile/views/widgets/loading.dart';
import 'package:provider/provider.dart';

class TransactionHistoryBody extends StatefulWidget {
  const TransactionHistoryBody({Key? key, this.animationController})
      : super(key: key);
  final AnimationController? animationController;

  @override
  State<TransactionHistoryBody> createState() => _TransactionHistoryBodyState();
}

class _TransactionHistoryBodyState extends State<TransactionHistoryBody> {
  Animation<double>? topBarAnimation;

  final _transactionVM = TransactionViewModel();
  final _walletVM = WalletViewModel();
  final _firebaseAuth = FirebaseAuth.instance;

  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );

    _firebaseAuth.currentUser!.getIdToken().then((idToken) async {
      await _walletVM.getWallet(idToken: idToken);

      _firebaseAuth.currentUser!.getIdToken().then((idToken) {
        _transactionVM.getTransactions(idToken: idToken);
      });
    });

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
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
              getAppBarUI(),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        ),
      ),
    );
  }

  Widget getHistoryViewUI() {
    return ChangeNotifierProvider<TransactionViewModel>(
      create: (BuildContext context) => _transactionVM,
      child: Consumer<TransactionViewModel>(
        builder: (context, viewModel, _) {
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
                  viewModel.transactions.message ?? "Something went wrong.",
                ),
              );
            case Status.COMPLETED:
              return ListView.builder(
                addAutomaticKeepAlives: false,
                controller: scrollController,
                padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      MediaQuery.of(context).padding.top +
                      24,
                  bottom: 62 + MediaQuery.of(context).padding.bottom,
                ),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    addAutomaticKeepAlives: false,
                    itemCount: viewModel.transactions.data!.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      widget.animationController?.forward();
                      final Transactions transaction =
                          viewModel.transactions.data![index];
                      var date = DateFormat("dd/MM/yyyy").format(
                        DateTime.parse(transaction.transactionDate!).toLocal(),
                      );
                      var amount = NumberFormat.currency(
                        locale: 'vi_VN',
                        decimalDigits: 0,
                        symbol: 'đ',
                      ).format(transaction.amount);

                      final jarName =
                          getJarNameByJarId(jarID: transaction.walletId!)!;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: SvgPicture.asset(
                                Utilities.getJarImageByName(jarName),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  TransactionDetails.routeName,
                                  arguments: TransactionDetailsScreenArguments(
                                    transactionId: transaction.id!,
                                  ),
                                );
                              },
                              title: Text(
                                jarName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    transaction.amount!.isNegative
                                        ? amount
                                        : "+$amount",
                                    style: TextStyle(
                                      color: transaction.amount!.isNegative
                                          ? Colors.red
                                          : Colors.green,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    date,
                                    style: const TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            default:
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: [
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  30 * (1.0 - topBarAnimation!.value),
                  0.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4 * topBarOpacity),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).padding.top),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16 - 8.0 * topBarOpacity,
                          bottom: 12 - 8.0 * topBarOpacity,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Transaction History',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  String? getJarNameByJarId({required int jarID}) {
    for (Wallet element in _walletVM.wallet.data!) {
      if (element.id == jarID) return element.name!;
    }
    return null;
  }
}
