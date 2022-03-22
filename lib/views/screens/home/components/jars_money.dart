import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/data/remote/response/status.dart';
import 'package:jars_mobile/utils/utilities.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/screens/home/components/jar_money_box.dart';
import 'package:jars_mobile/views/widgets/loading.dart';
import 'package:provider/provider.dart';

class JarsMoney extends StatefulWidget {
  const JarsMoney({
    Key? key,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<JarsMoney> createState() => _JarsMoneyState();
}

class _JarsMoneyState extends State<JarsMoney> with TickerProviderStateMixin {
  AnimationController? animationController;
  final walletVM = WalletViewModel();
  final _firebaseAuth = FirebaseAuth.instance;

  List<Widget> listViews = [];

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _firebaseAuth.currentUser!.getIdToken().then((idToken) {
      walletVM.getWallet(idToken: idToken);
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
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
                  child: ChangeNotifierProvider<WalletViewModel>(
                    create: (BuildContext context) => walletVM,
                    child: Consumer<WalletViewModel>(
                      builder: (context, viewModel, _) {
                        switch (viewModel.wallet.status) {
                          case Status.LOADING:
                            return LoadingWidget();
                          case Status.ERROR:
                            return ErrorWidget(
                              viewModel.wallet.message ??
                                  "Something went wrong",
                            );
                          case Status.COMPLETED:
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: viewModel.wallet.data!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final int count = viewModel.wallet.data!.length;

                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: animationController!,
                                    curve: Interval(
                                      (1 / count) * index,
                                      1.0,
                                      curve: Curves.fastOutSlowIn,
                                    ),
                                  ),
                                );

                                animationController?.forward();

                                return JarMoneyBox(
                                  jarName: viewModel.wallet.data![index].name!,
                                  jarImage: Utilities.getJarImageByName(
                                    viewModel.wallet.data![index].name!,
                                  ),
                                  jarColor: Utilities.getJarColorByName(
                                    viewModel.wallet.data![index].name!,
                                  ),
                                  totalMoney: viewModel
                                      .wallet.data![index].totalAdded!
                                      .toInt(),
                                  spendMoney: viewModel
                                      .wallet.data![index].totalSpend
                                      .toInt(),
                                  animation: animation,
                                  animationController: animationController!,
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisExtent: 65,
                              ),
                            );
                          default:
                        }
                        return Container();
                      },
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
