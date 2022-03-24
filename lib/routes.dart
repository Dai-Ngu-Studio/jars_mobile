import 'package:flutter/material.dart';
import 'package:jars_mobile/views/screens/add_contract/add_contract.dart';
import 'package:jars_mobile/views/screens/add_contract/detail_contract.dart';
import 'package:jars_mobile/views/screens/add_contract/view_contracts.dart';
import 'package:jars_mobile/views/screens/add_transaction/add_transaction_screen.dart';
import 'package:jars_mobile/views/screens/app/app.dart';
import 'package:jars_mobile/views/screens/app_info/app_info_screen.dart';
import 'package:jars_mobile/views/screens/bill_details/bill_details_screen.dart';
import 'package:jars_mobile/views/screens/factory_reset/factory_reset_screen.dart';
import 'package:jars_mobile/views/screens/general_settings/general_settings_screen.dart';
import 'package:jars_mobile/views/screens/login/login_screen.dart';
import 'package:jars_mobile/views/screens/transaction_details/transaction_details_screen.dart';
import 'package:jars_mobile/views/screens/bill/bill_screen.dart';
import 'package:jars_mobile/views/screens/create_bill/create_bill_screen.dart';
import 'package:jars_mobile/views/screens/create_bill_details/create_bill_details_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  JarsApp.routeName: (context) => const JarsApp(),
  AddTransactionScreen.routeName: (context) => const AddTransactionScreen(),
  AppInfoScreen.routeName: (context) => const AppInfoScreen(),
  GeneralSettingsScreen.routeName: (context) => const GeneralSettingsScreen(),
  FactoryResetScreen.routeName: (context) => const FactoryResetScreen(),
  TransactionDetails.routeName: (context) => const TransactionDetails(),
  BillScreen.routeName: (context) => const BillScreen(),
  CreateBillScreen.routeName: (context) => const CreateBillScreen(),
  CreateBillDetailsScreen.routeName: (context) {
    return const CreateBillDetailsScreen();
  },
  BillDetailsScreen.routeName: (context) => const BillDetailsScreen(),
  AddContractScreen.routeName: (context) => const AddContractScreen(),
  ListContractScreen.routeName : (context) => const ListContractScreen(),
  DetailContractScreen.routeName : (context) => const DetailContractScreen(),
};
