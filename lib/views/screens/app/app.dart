import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jars_mobile/data/models/tab_icon_data.dart';
import 'package:jars_mobile/service/local_notification/local_notification_service.dart';
import 'package:jars_mobile/views/screens/add_transaction/add_transaction_screen.dart';
import 'package:jars_mobile/views/screens/app/components/bottom_bar_view.dart';
import 'package:jars_mobile/views/screens/home/home_body.dart';
import 'package:jars_mobile/views/screens/jars_setting/jars_setting_body.dart';
import 'package:jars_mobile/views/screens/settings/settings_body.dart';

class JarsApp extends StatefulWidget {
  const JarsApp({Key? key}) : super(key: key);

  static String routeName = '/home';

  @override
  State<JarsApp> createState() => _JarsAppState();
}

class _JarsAppState extends State<JarsApp> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: const Color(0xFFf2f3f8),
  );

  @override
  void initState() {
    super.initState();
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    tabBody = HomeBody(animationController: animationController);

    LocalNotificationService.initialize(context);

    // give message on which user taps and it opened the app from terminated state (app close)
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    // just in foreground (app must open)
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }

      LocalNotificationService.display(message);
    });

    // this just work when app in background (app not open) and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: const Color(0xFFf2f3f8),
      body: Stack(
        children: [
          tabBody,
          bottomBar(),
        ],
      ),
    );
  }

  Widget bottomBar() {
    return Column(
      children: [
        const Expanded(child: SizedBox()),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            Navigator.of(context).pushNamed(
              AddTransactionScreen.routeName,
              arguments: AddTransactionScreenArguments(tabIndex: 1),
            );
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) return;
                setState(() {
                  tabBody = HomeBody(
                    animationController: animationController,
                  );
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) return;
                setState(() {
                  tabBody = JarsSettingBody(
                    animationController: animationController,
                  );
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) return;
                setState(() {
                  // tabBody =
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) return;
                setState(() {
                  tabBody = SettingsBody(
                    animationController: animationController,
                  );
                });
              });
            }
          },
        ),
      ],
    );
  }
}
