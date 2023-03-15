import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:jars_mobile/constants/colors.dart';
import 'package:jars_mobile/firebase_options.dart';
import 'package:jars_mobile/routes.dart';
import 'package:jars_mobile/view_model/account_view_model.dart';
import 'package:jars_mobile/view_model/bill_details_view_model.dart';
import 'package:jars_mobile/view_model/cloud_view_model.dart';
import 'package:jars_mobile/view_model/contract_view_model.dart';
import 'package:jars_mobile/view_model/note_view_model.dart';
import 'package:jars_mobile/view_model/transaction_view_model.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  log(message.data.toString());
  log(message.notification!.title.toString());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  HttpOverrides.global = MyHttpOverrides();
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) FlutterNativeSplash.remove();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountViewModel()),
        ChangeNotifierProvider(create: (_) => WalletViewModel()),
        ChangeNotifierProvider(create: (_) => BillDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => CloudViewModel()),
        ChangeNotifierProvider(create: (_) => ContractViewModel()),
        ChangeNotifierProvider(create: (_) => NoteViewModel()),
        ChangeNotifierProvider(create: (_) => TransactionViewModel()),
        ChangeNotifierProvider(create: (_) => WalletViewModel()),
      ],
      child: MaterialApp(
        title: 'JARS',
        theme: ThemeData(primarySwatch: jarsColor),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: routes,
      ),
    );
  }
}
