import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/views/screens/home/home_screen.dart';
import 'package:jars_mobile/views/screens/login/login_screen.dart';
import 'package:jars_mobile/service/local_notification/local_notification_service.dart';

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  late FirebaseAuth _auth;
  late User? _user;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}
