import 'package:flutter/material.dart';
import 'package:jars_mobile/data/models/wallet.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/views/screens/jars_setting/components/jars_percentage_box.dart';

class JarsPercentage extends StatefulWidget {
  const JarsPercentage({
    Key? key,
    this.animationController,
    this.animation,
    required this.onPressed,
    required this.necessitiesWallet,
    required this.educationWallet,
    required this.savingWallet,
    required this.playWallet,
    required this.investmentWallet,
    required this.giveWallet,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;

  final Wallet necessitiesWallet;
  final Wallet educationWallet;
  final Wallet savingWallet;
  final Wallet playWallet;
  final Wallet investmentWallet;
  final Wallet giveWallet;

  final Function onPressed;

  @override
  State<JarsPercentage> createState() => _JarsPercentageState();
}

class _JarsPercentageState extends State<JarsPercentage> with TickerProviderStateMixin {
  final _necessitiesController = TextEditingController();
  final _educationController = TextEditingController();
  final _savingController = TextEditingController();
  final _playController = TextEditingController();
  final _investmentController = TextEditingController();
  final _giveController = TextEditingController();
  AnimationController? animationController;

  List<Widget> listViews = [];

  List<Map<String, dynamic>> listData = [];

  num total = 100;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _necessitiesController.text = widget.necessitiesWallet.percentage.toString();
    _educationController.text = widget.educationWallet.percentage.toString();
    _savingController.text = widget.savingWallet.percentage.toString();
    _playController.text = widget.playWallet.percentage.toString();
    _investmentController.text = widget.investmentWallet.percentage.toString();
    _giveController.text = widget.giveWallet.percentage.toString();

    listData = [
      {
        'jar': widget.necessitiesWallet,
        'controller': _necessitiesController,
        'image': Assets.svgs.jarNecessities.path,
      },
      {
        'jar': widget.educationWallet,
        'controller': _educationController,
        'image': Assets.svgs.jarEducation.path,
      },
      {
        'jar': widget.savingWallet,
        'controller': _savingController,
        'image': Assets.svgs.jarSaving.path,
      },
      {
        'jar': widget.playWallet,
        'controller': _playController,
        'image': Assets.svgs.jarPlay.path,
      },
      {
        'jar': widget.investmentWallet,
        'controller': _investmentController,
        'image': Assets.svgs.jarInvestment.path,
      },
      {
        'jar': widget.giveWallet,
        'controller': _giveController,
        'image': Assets.svgs.jarGive.path,
      },
    ];
  }

  @override
  void dispose() {
    _necessitiesController.dispose();
    _educationController.dispose();
    _savingController.dispose();
    _playController.dispose();
    _investmentController.dispose();
    _giveController.dispose();
    animationController?.dispose();
    super.dispose();
  }

  int get totalPercentage {
    return int.parse(_necessitiesController.text) +
        int.parse(_educationController.text) +
        int.parse(_savingController.text) +
        int.parse(_playController.text) +
        int.parse(_investmentController.text) +
        int.parse(_giveController.text);
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
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
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, bottom: 10),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              const TextSpan(text: 'Total: '),
                              TextSpan(
                                text: '$total%',
                                style: TextStyle(
                                  color: totalPercentage != 100 ? Colors.red : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: listData.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
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

                          return JarsPercentageBox(
                            animation: animation,
                            animationController: animationController!,
                            controller: listData[index]['controller'],
                            jarImage: listData[index]['image'],
                            jarName: listData[index]['jar'].toJson()['name'],
                            onChanged: () {
                              setState(() {
                                total = 0;
                                for (int i = 0; i < listData.length; i++) {
                                  total += int.parse(listData[i]['controller'].text);
                                }
                                widget.onPressed(
                                  wallet: listData[index]['jar'],
                                  percentage: int.parse(listData[index]['controller'].text),
                                );
                              });
                            },
                          );
                        },
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisExtent: 80,
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
}
