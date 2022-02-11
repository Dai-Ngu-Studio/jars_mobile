import 'package:flutter/material.dart';
import 'package:jars_mobile/screens/home/home_screen.dart';
import 'package:jars_mobile/screens/login/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
};