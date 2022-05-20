import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class JarMoneyBox extends StatelessWidget {
  const JarMoneyBox({
    Key? key,
    this.animationController,
    this.animation,
    required this.jarName,
    required this.jarImage,
    required this.jarColor,
    required this.remainingMoney,
    required this.spendMoney,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;

  final String jarName;
  final String jarImage;
  final Color jarColor;
  final int remainingMoney;
  final int spendMoney;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              50 * (1.0 - animation!.value),
              0.0,
            ),
            child: Row(
              children: [
                SvgPicture.asset(jarImage, width: 25),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            jarName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: -0.2,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'vi_VN',
                              decimalDigits: 0,
                              symbol: 'đ',
                            ).format(remainingMoney),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Container(
                          height: 4,
                          width: MediaQuery.of(context).size.width -
                              115, //24 + 24 + 16 + 16 + 25 + 10
                          decoration: BoxDecoration(
                            color: jarColor.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: remainingMoney != 0
                                    ?
                                    // VD: có 12tr và tiêu 3tr
                                    // 12tr : tổng tiền
                                    // 3tr : tiền tiêu
                                    // MediaQuery.of(context).size.width - 115 : 100%
                                    // 3 * (MediaQuery.of(context).size.width - 115) / 12 = 25 (tỉ lệ tiền tiêu)
                                    // tổng 12tr, tiêu 3tr, còn lại 9tr tương đương tiêu 25% tổng tiền
                                    // ((MediaQuery.of(context).size.width - 115) - (3 * (MediaQuery.of(context).size.width - 115) / 12))
                                    // tổng tiền  -      tiền tiêu      = còn lại
                                    //    ↑                 ↑                ↑
                                    //  (12tr)    - (3tr * 100% / 12tr) =   9tr
                                    //                     ↑
                                    //   (MediaQuery.of(context).size.width - 115)
                                    //                   ↑                     ↑
                                    //              screen size   padding + jars image + sized box
                                    //                              ↑           ↑            ↑
                                    //                         24*2 + 16*2  +   25     +     10      = 115
                                    ((MediaQuery.of(context).size.width - 115) -
                                            (spendMoney *
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    115) /
                                                remainingMoney)) *
                                        animation!.value
                                    : 0,
                                height: 4,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      jarColor,
                                      jarColor.withOpacity(0.5),
                                    ],
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
