import 'package:flutter/material.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/views/screens/jars_setting/components/jars_percentage_box.dart';

class JarsPercentage extends StatefulWidget {
  const JarsPercentage({
    Key? key,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<JarsPercentage> createState() => _JarsPercentageState();
}

class _JarsPercentageState extends State<JarsPercentage>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  final TextEditingController? _necessitiesController = TextEditingController();
  final TextEditingController? _educationController = TextEditingController();
  final TextEditingController? _savingController = TextEditingController();
  final TextEditingController? _playController = TextEditingController();
  final TextEditingController? _investmentController = TextEditingController();
  final TextEditingController? _giveController = TextEditingController();

  List<Widget> listViews = [];

  List<Map<String, dynamic>> listData = [];

  num total = 100;

  @override
  void initState() {
    super.initState();
    // addAllListWidget();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // TODO: implement wallet API
    _necessitiesController!.text = '55';
    _educationController!.text = '10';
    _savingController!.text = '10';
    _playController!.text = '10';
    _investmentController!.text = '10';
    _giveController!.text = '5';

    listData = [
      {
        'jarName': 'Necessities',
        'controller': _necessitiesController,
        'image': Assets.svgs.jarNecessities.path,
      },
      {
        'jarName': 'Education',
        'controller': _educationController,
        'image': Assets.svgs.jarEducation.path,
      },
      {
        'jarName': 'Saving',
        'controller': _savingController,
        'image': Assets.svgs.jarSaving.path,
      },
      {
        'jarName': 'Play',
        'controller': _playController,
        'image': Assets.svgs.jarPlay.path,
      },
      {
        'jarName': 'Investment',
        'controller': _investmentController,
        'image': Assets.svgs.jarInvestment.path,
      },
      {
        'jarName': 'Give',
        'controller': _giveController,
        'image': Assets.svgs.jarGive.path,
      },
    ];
  }

  @override
  void dispose() {
    _necessitiesController!.dispose();
    _educationController!.dispose();
    _savingController!.dispose();
    _playController!.dispose();
    _investmentController!.dispose();
    _giveController!.dispose();
    super.dispose();
  }

  int get totalPercentage {
    return int.parse(_necessitiesController!.text) +
        int.parse(_educationController!.text) +
        int.parse(_savingController!.text) +
        int.parse(_playController!.text) +
        int.parse(_investmentController!.text) +
        int.parse(_giveController!.text);
  }

  // void addAllListWidget() {
  //   const int count = 6;

  //   listViews.add(
  //     JarsPercentageBox(
  //       controller: _necessitiesController!,
  //       jarImage: Assets.svgs.jarNecessities.path,
  //       jarName: 'Necessities',
  //       animation: Tween<double>(begin: 0.0, end: 1.0).animate(
  //         CurvedAnimation(
  //           parent: widget.animationController!,
  //           curve: const Interval(
  //             (1 / count) * 0,
  //             1.0,
  //             curve: Curves.fastOutSlowIn,
  //           ),
  //         ),
  //       ),
  //       animationController: widget.animationController!,
  //     ),
  //   );

  //   listViews.add(
  //     JarsPercentageBox(
  //       controller: _educationController!,
  //       jarImage: Assets.svgs.jarEducation.path,
  //       jarName: 'Education',
  //       animation: Tween<double>(begin: 0.0, end: 1.0).animate(
  //         CurvedAnimation(
  //           parent: widget.animationController!,
  //           curve: const Interval(
  //             (1 / count) * 1,
  //             1.0,
  //             curve: Curves.fastOutSlowIn,
  //           ),
  //         ),
  //       ),
  //       animationController: widget.animationController!,
  //     ),
  //   );

  //   listViews.add(
  //     JarsPercentageBox(
  //       controller: _savingController!,
  //       jarImage: Assets.svgs.jarSaving.path,
  //       jarName: 'Saving',
  //       animation: Tween<double>(begin: 0.0, end: 1.0).animate(
  //         CurvedAnimation(
  //           parent: widget.animationController!,
  //           curve: const Interval(
  //             (1 / count) * 2,
  //             1.0,
  //             curve: Curves.fastOutSlowIn,
  //           ),
  //         ),
  //       ),
  //       animationController: widget.animationController!,
  //     ),
  //   );

  //   listViews.add(
  //     JarsPercentageBox(
  //       controller: _playController!,
  //       jarImage: Assets.svgs.jarPlay.path,
  //       jarName: 'Play',
  //       animation: Tween<double>(begin: 0.0, end: 1.0).animate(
  //         CurvedAnimation(
  //           parent: widget.animationController!,
  //           curve: const Interval(
  //             (1 / count) * 3,
  //             1.0,
  //             curve: Curves.fastOutSlowIn,
  //           ),
  //         ),
  //       ),
  //       animationController: widget.animationController!,
  //     ),
  //   );

  //   listViews.add(
  //     JarsPercentageBox(
  //       controller: _investmentController!,
  //       jarImage: Assets.svgs.jarInvestment.path,
  //       jarName: 'Investment',
  //       animation: Tween<double>(begin: 0.0, end: 1.0).animate(
  //         CurvedAnimation(
  //           parent: widget.animationController!,
  //           curve: const Interval(
  //             (1 / count) * 4,
  //             1.0,
  //             curve: Curves.fastOutSlowIn,
  //           ),
  //         ),
  //       ),
  //       animationController: widget.animationController!,
  //     ),
  //   );

  //   listViews.add(
  //     JarsPercentageBox(
  //       controller: _giveController!,
  //       jarImage: Assets.svgs.jarGive.path,
  //       jarName: 'Give',
  //       animation: Tween<double>(begin: 0.0, end: 1.0).animate(
  //         CurvedAnimation(
  //           parent: widget.animationController!,
  //           curve: const Interval(
  //             (1 / count) * 5,
  //             1.0,
  //             curve: Curves.fastOutSlowIn,
  //           ),
  //         ),
  //       ),
  //       animationController: widget.animationController!,
  //     ),
  //   );
  // }

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
                                  color: totalPercentage != 100
                                      ? Colors.red
                                      : Colors.black,
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
                            jarName: listData[index]['jarName'],
                            onChanged: () {
                              setState(() {
                                total = 0;
                                for (int i = 0; i < listData.length; i++) {
                                  total += int.parse(
                                    listData[i]['controller'].text,
                                  );
                                }
                              });
                            },
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 5,
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
