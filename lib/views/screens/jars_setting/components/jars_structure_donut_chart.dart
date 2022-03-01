import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/views/widgets/indicator.dart';
import 'package:jars_mobile/views/widgets/pie_chart_badge.dart';

class JarsStructureDonutChart extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const JarsStructureDonutChart({
    Key? key,
    this.animationController,
    this.animation,
  }) : super(key: key);

  @override
  State<JarsStructureDonutChart> createState() {
    return _JarsStructureDonutChartState();
  }
}

class _JarsStructureDonutChartState extends State<JarsStructureDonutChart> {
  int touchedIndex = -1;

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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 36,
                        bottom: 16,
                      ),
                      child: AspectRatio(
                        aspectRatio:
                            MediaQuery.of(context).size.width < 350 ? 1.3 : 1.7,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            }),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 0,
                            startDegreeOffset: -90,
                            centerSpaceRadius:
                                MediaQuery.of(context).size.width < 350
                                    ? 30
                                    : 40,
                            sections: showingSections(
                              animation: widget.animation!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 16,
                      indent: 24,
                      endIndent: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Indicator(
                            color: kNecessitiesColor,
                            text: 'Necessities',
                            isSquare: true,
                            size: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const SizedBox(height: 4),
                          Indicator(
                            color: kEducationColor,
                            text: 'Education',
                            isSquare: true,
                            size: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const SizedBox(height: 4),
                          Indicator(
                            color: kSavingColor,
                            text: 'Saving',
                            isSquare: true,
                            size: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const SizedBox(height: 18),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Indicator(
                            color: kPlayColor,
                            text: 'Play',
                            isSquare: true,
                            size: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const SizedBox(height: 4),
                          Indicator(
                            color: kInvestmentColor,
                            text: 'Investment',
                            isSquare: true,
                            size: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const SizedBox(height: 4),
                          Indicator(
                            color: kGiveColor,
                            text: 'Give',
                            isSquare: true,
                            size: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const SizedBox(height: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<PieChartSectionData> showingSections({
    required Animation<double>? animation,
  }) {
    return List.generate(6, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: kNecessitiesColor,
            value: 55,
            title: '${(55 * animation!.value).toInt()}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: DonutChartBadge(
              Assets.svgs.jarNecessities.path,
              borderColor: kNecessitiesColor,
              size: 40,
              title: 'Necessities',
              text:
                  "This jar is for managing your everyday expenses and bills. This would include things like your rent, mortgage, utilities, bills, taxes, food, clothes, etc. Basically it includes anything that you need to live, the necessities.",
            ),
            badgePositionPercentageOffset: 1.2,
          );
        case 1:
          return PieChartSectionData(
            color: kEducationColor,
            value: (10 * animation!.value).toDouble(),
            title: '${(10 * animation.value).toInt()}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: DonutChartBadge(
              Assets.svgs.jarEducation.path,
              borderColor: kEducationColor,
              size: 40,
              title: 'Education',
              text:
                  "Money in this jar is meant to further your education and personal growth. An investment in yourself is a great way to use your money. You are your most valuable asset. Never forget this. Education money can be used to purchase books, CD's, courses or anything else that has educational value.",
            ),
            badgePositionPercentageOffset: 1.2,
          );
        case 2:
          return PieChartSectionData(
            color: kSavingColor,
            value: (10 * animation!.value).toDouble(),
            title: '${(10 * animation.value).toInt()}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: DonutChartBadge(
              Assets.svgs.jarSaving.path,
              borderColor: kSavingColor,
              size: 40,
              title: 'Saving',
              text:
                  "Money in this jar is for bigger, nice-to-have purchases. Use the money for vacations, extravagances, a plasma TV, contingency fund, your children's education etc. A small monthly contribution can go a long way",
            ),
            badgePositionPercentageOffset: 1.2,
          );
        case 3:
          return PieChartSectionData(
            color: kPlayColor,
            value: (10 * animation!.value).toDouble(),
            title: '${(10 * animation.value).toInt()}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: DonutChartBadge(
              Assets.svgs.jarPlay.path,
              borderColor: kPlayColor,
              size: 40,
              title: 'Play',
              text:
                  "PLAY money is spent every month on purchases you wouldn't normally make. The purpose of this jar is to nurture yourself. You could purchase an expensive bottle of wine at dinner, get a massage or go on a weekend getaway. Play can be anything your heart desires. You and a spouse can each receive your own play money, and not even ask what the other person spends it on!",
            ),
            badgePositionPercentageOffset: 1.2,
          );
        case 4:
          return PieChartSectionData(
            color: kInvestmentColor,
            value: (10 * animation!.value).toDouble(),
            title: '${(10 * animation.value).toInt()}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: DonutChartBadge(
              Assets.svgs.jarInvestment.path,
              borderColor: kInvestmentColor,
              size: 40,
              title: 'Investment',
              text:
                  "This is your golden goose. This jar is your ticket to financial freedom. The money that you put into this jar is used for investments and building your passive income streams. You never spend this money. The only time you would spend this money is once you become financially free. Even then you would only spend the returns on your investment. Never spend the principal.",
            ),
            badgePositionPercentageOffset: 1.2,
          );
        case 5:
          return PieChartSectionData(
            color: kGiveColor,
            value: (5 * animation!.value).toDouble(),
            title: '${(5 * animation.value).toInt()}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            badgeWidget: DonutChartBadge(
              Assets.svgs.jarGive.path,
              borderColor: kGiveColor,
              size: 40,
              title: 'Give',
              text:
                  "Money in this jar is for giving away. Use the money for family and friends on birthdays, special occasions and holidays. You can also give away your time as opposed to giving away money. You could house sit for a neighbor, take a friend's dog for a walk or volunteer in your community or for your favorite charity.",
            ),
            badgePositionPercentageOffset: 1.2,
          );
        default:
          throw Error();
      }
    });
  }
}
