import 'package:flutter/material.dart';
import 'package:jars_mobile/views/screens/factory_reset/factory_reset_screen.dart';
import 'package:jars_mobile/views/screens/settings/components/setting_menu.dart';

class GeneralSettingsBody extends StatelessWidget {
  const GeneralSettingsBody({Key? key, this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          SettingMenu(
            animationController: animationController,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController!,
                curve: const Interval(
                  (1 / 1) * 0,
                  1.0,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
            ),
            text: 'Factory Reset',
            onPressed: () {
              Navigator.of(context).pushNamed(FactoryResetScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
