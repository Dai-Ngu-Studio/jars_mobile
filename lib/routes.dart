import 'package:flutter/material.dart';
import 'package:jars_mobile/views/add_transaction/add_transaction_screen.dart';
import 'package:jars_mobile/views/screens/app/app.dart';
import 'package:jars_mobile/views/screens/app_info/app_info_screen.dart';
import 'package:jars_mobile/views/screens/factory_reset/factory_reset_screen.dart';
import 'package:jars_mobile/views/screens/general_settings/general_settings_screen.dart';
import 'package:jars_mobile/views/screens/login/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  JarsApp.routeName: (context) => const JarsApp(),
  AddTransactionScreen.routeName: (context) => const AddTransactionScreen(),
  AppInfoScreen.routeName: (context) => const AppInfoScreen(),
  GeneralSettingsScreen.routeName: (context) => const GeneralSettingsScreen(),
  FactoryResetScreen.routeName: (context) => const FactoryResetScreen(),
};
