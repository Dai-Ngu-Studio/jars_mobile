import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/data/remote/response/status.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/screens/jars_setting/components/jars_percentage.dart';
import 'package:jars_mobile/views/screens/jars_setting/components/jars_structure_donut_chart.dart';
import 'package:jars_mobile/views/widgets/loading.dart';
import 'package:jars_mobile/views/widgets/title_button_widet.dart';
import 'package:provider/provider.dart';

class JarsSettingBody extends StatefulWidget {
  const JarsSettingBody({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  State<JarsSettingBody> createState() => _JarsSettingBodyState();
}

class _JarsSettingBodyState extends State<JarsSettingBody>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  Wallet? _necessitiesWallet = Wallet();
  Wallet? _educationWallet = Wallet();
  Wallet? _savingWallet = Wallet();
  Wallet? _playWallet = Wallet();
  Wallet? _investmentWallet = Wallet();
  Wallet? _giveWallet = Wallet();

  final walletVM = WalletViewModel();
  final _firebaseAuth = FirebaseAuth.instance;

  List<Widget> listViews = [];
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
    _firebaseAuth.currentUser!.getIdToken().then((idToken) {
      walletVM.getWallet(idToken: idToken).whenComplete(() {
        _necessitiesWallet = Wallet(
          name: walletVM.wallet.data![0].name,
          walletAmount: walletVM.wallet.data![0].walletAmount,
          accountId: walletVM.wallet.data![0].accountId,
          id: walletVM.wallet.data![0].id,
          categoryWalletId: walletVM.wallet.data![0].categoryWalletId,
          percentage: walletVM.wallet.data![0].percentage,
          startDate: walletVM.wallet.data![0].startDate,
        );

        _investmentWallet = Wallet(
          name: walletVM.wallet.data![1].name,
          walletAmount: walletVM.wallet.data![1].walletAmount,
          accountId: walletVM.wallet.data![1].accountId,
          id: walletVM.wallet.data![1].id,
          categoryWalletId: walletVM.wallet.data![1].categoryWalletId,
          percentage: walletVM.wallet.data![1].percentage,
          startDate: walletVM.wallet.data![1].startDate,
        );

        _savingWallet = Wallet(
          name: walletVM.wallet.data![2].name,
          walletAmount: walletVM.wallet.data![2].walletAmount,
          accountId: walletVM.wallet.data![2].accountId,
          id: walletVM.wallet.data![2].id,
          categoryWalletId: walletVM.wallet.data![2].categoryWalletId,
          percentage: walletVM.wallet.data![2].percentage,
          startDate: walletVM.wallet.data![2].startDate,
        );

        _educationWallet = Wallet(
          name: walletVM.wallet.data![3].name,
          walletAmount: walletVM.wallet.data![3].walletAmount,
          accountId: walletVM.wallet.data![3].accountId,
          id: walletVM.wallet.data![3].id,
          categoryWalletId: walletVM.wallet.data![3].categoryWalletId,
          percentage: walletVM.wallet.data![3].percentage,
          startDate: walletVM.wallet.data![3].startDate,
        );

        _playWallet = Wallet(
          name: walletVM.wallet.data![4].name,
          walletAmount: walletVM.wallet.data![4].walletAmount,
          accountId: walletVM.wallet.data![4].accountId,
          id: walletVM.wallet.data![4].id,
          categoryWalletId: walletVM.wallet.data![4].categoryWalletId,
          percentage: walletVM.wallet.data![4].percentage,
          startDate: walletVM.wallet.data![4].startDate,
        );

        _giveWallet = Wallet(
          name: walletVM.wallet.data![5].name,
          walletAmount: walletVM.wallet.data![5].walletAmount,
          accountId: walletVM.wallet.data![5].accountId,
          id: walletVM.wallet.data![5].id,
          categoryWalletId: walletVM.wallet.data![5].categoryWalletId,
          percentage: walletVM.wallet.data![5].percentage,
          startDate: walletVM.wallet.data![5].startDate,
        );

        addAllListData();
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

  void addAllListData() {
    const int count = 4;

    listViews.add(
      TitleView(
        titleTxt: 'Jars Structure',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(
              (1 / count) * 0,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      JarsStructureDonutChart(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(
              (1 / count) * 1,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController!,
        educationWallet: _educationWallet!,
        giveWallet: _giveWallet!,
        investmentWallet: _investmentWallet!,
        necessitiesWallet: _necessitiesWallet!,
        playWallet: _playWallet!,
        savingWallet: _savingWallet!,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Jars percentage',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(
              (1 / count) * 2,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      JarsPercentage(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(
              (1 / count) * 3,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController!,
        onPressed: updateJarPercentage,
        educationWallet: _educationWallet!,
        giveWallet: _giveWallet!,
        investmentWallet: _investmentWallet!,
        necessitiesWallet: _necessitiesWallet!,
        playWallet: _playWallet!,
        savingWallet: _savingWallet!,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
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
              getMainListViewUI(),
              getAppBarUI(),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong! Please try again later."),
          );
        } else {
          return ChangeNotifierProvider<WalletViewModel>(
            create: (BuildContext context) => walletVM,
            child: Consumer<WalletViewModel>(
              builder: (context, viewModel, _) {
                switch (viewModel.wallet.status) {
                  case Status.LOADING:
                    return LoadingWidget();
                  case Status.ERROR:
                    return ErrorWidget(
                      viewModel.wallet.message ?? "Something went wrong",
                    );
                  case Status.COMPLETED:
                    return ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: AppBar().preferredSize.height +
                            MediaQuery.of(context).padding.top +
                            24,
                        bottom: 62 + MediaQuery.of(context).padding.bottom,
                      ),
                      itemCount: listViews.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        widget.animationController?.forward();
                        return listViews[index];
                      },
                    );
                  default:
                }
                return const SizedBox.shrink();
              },
            ),
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
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
                                  'Jars Setting',
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
                            TextButton(
                              onPressed: getTotalPercentage() == 100
                                  ? () {
                                      FirebaseAuth.instance.currentUser!
                                          .getIdToken()
                                          .then((idToken) {
                                        walletVM.putWallet(
                                          idToken: idToken,
                                          wallet: _necessitiesWallet!,
                                        );

                                        walletVM.putWallet(
                                          idToken: idToken,
                                          wallet: _investmentWallet!,
                                        );

                                        walletVM.putWallet(
                                          idToken: idToken,
                                          wallet: _savingWallet!,
                                        );

                                        walletVM.putWallet(
                                          idToken: idToken,
                                          wallet: _educationWallet!,
                                        );

                                        walletVM.putWallet(
                                          idToken: idToken,
                                          wallet: _playWallet!,
                                        );

                                        walletVM.putWallet(
                                          idToken: idToken,
                                          wallet: _giveWallet!,
                                        );
                                      });
                                    }
                                  : () {
                                      Fluttertoast.showToast(
                                        msg:
                                            "Total percentage of all jars must be 100%",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey.shade200,
                                        textColor: Colors.black,
                                        fontSize: 15.0,
                                      );
                                    },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  color: jarsColor,
                                  fontSize: 18,
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

  void updateJarPercentage({required Wallet wallet, required int percentage}) {
    switch (wallet.name) {
      case "Necessities":
        setState(() => _necessitiesWallet!.percentage = percentage);
        break;
      case "Education":
        setState(() => _educationWallet!.percentage = percentage);
        break;
      case "Saving":
        setState(() => _savingWallet!.percentage = percentage);
        break;
      case "Play":
        setState(() => _playWallet!.percentage = percentage);
        break;
      case "Investment":
        setState(() => _investmentWallet!.percentage = percentage);
        break;
      case "Give":
        setState(() => _giveWallet!.percentage = percentage);
        break;
    }
  }

  int getTotalPercentage() {
    int totalPercentage = 0;
    totalPercentage += _necessitiesWallet!.percentage ?? 0;
    totalPercentage += _educationWallet!.percentage ?? 0;
    totalPercentage += _savingWallet!.percentage ?? 0;
    totalPercentage += _playWallet!.percentage ?? 0;
    totalPercentage += _investmentWallet!.percentage ?? 0;
    totalPercentage += _giveWallet!.percentage ?? 0;
    return totalPercentage;
  }
}
