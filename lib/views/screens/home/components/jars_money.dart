import 'package:flutter/material.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/screens/home/components/jar_money_box.dart';

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

  List<Widget> listViews = [];

  List<Map<String, dynamic>> listData = [];

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // TODO: implement wallet api
    listData = [
      {
        'jarName': 'Necessities',
        'jarImage': Assets.svgs.jarNecessities.path,
        'jarColor': kNecessitiesColor,
        'totalMoney': 6600000,
        'spendMoney': 3000000,
      },
      {
        'jarName': 'Education',
        'jarImage': Assets.svgs.jarEducation.path,
        'jarColor': kEducationColor,
        'totalMoney': 1200000,
        'spendMoney': 200000,
      },
      {
        'jarName': 'Saving',
        'jarImage': Assets.svgs.jarSaving.path,
        'jarColor': kSavingColor,
        'totalMoney': 1200000,
        'spendMoney': 650000,
      },
      {
        'jarName': 'Play',
        'jarImage': Assets.svgs.jarPlay.path,
        'jarColor': kPlayColor,
        'totalMoney': 1200000,
        'spendMoney': 800000,
      },
      {
        'jarName': 'Investment',
        'jarImage': Assets.svgs.jarInvestment.path,
        'jarColor': kInvestmentColor,
        'totalMoney': 1200000,
        'spendMoney': 300000,
      },
      {
        'jarName': 'Give',
        'jarImage': Assets.svgs.jarGive.path,
        'jarColor': kGiveColor,
        'totalMoney': 600000,
        'spendMoney': 100000,
      },
    ];
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
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: listData.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final int count = listData.length;

                      final Animation<double> animation = Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(
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
                        jarName: listData[index]['jarName'],
                        jarImage: listData[index]['jarImage'],
                        jarColor: listData[index]['jarColor'],
                        totalMoney: listData[index]['totalMoney'],
                        spendMoney: listData[index]['spendMoney'],
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisExtent: 65,
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
