import 'package:flutter/material.dart';
import 'package:jars_mobile/views/screens/add_contract/add_contract.dart';
import 'package:jars_mobile/views/screens/add_contract/detail_contract.dart';
import 'package:jars_mobile/views/screens/add_contract/view_contracts.dart';
import 'package:jars_mobile/views/screens/add_transaction/add_transaction_screen.dart';
import 'package:jars_mobile/views/screens/app/app.dart';
import 'package:jars_mobile/views/screens/bill_details/bill_details_screen.dart';
import 'package:jars_mobile/views/screens/factory_reset/factory_reset_screen.dart';
import 'package:jars_mobile/views/screens/general_settings/general_settings_screen.dart';
import 'package:jars_mobile/views/screens/login/login_screen.dart';
import 'package:jars_mobile/views/screens/transaction_details/transaction_details_screen.dart';
import 'package:jars_mobile/views/screens/bill/bill_screen.dart';
import 'package:jars_mobile/views/screens/create_bill/create_bill_screen.dart';
import 'package:jars_mobile/views/screens/create_bill_details/create_bill_details_screen.dart';
import 'package:jars_mobile/views/screens/update_bill/update_bill_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (_) => const LoginScreen(),
  JarsApp.routeName: (_) => const JarsApp(),
  AddTransactionScreen.routeName: (_) => const AddTransactionScreen(),
  GeneralSettingsScreen.routeName: (_) => const GeneralSettingsScreen(),
  FactoryResetScreen.routeName: (_) => const FactoryResetScreen(),
  TransactionDetails.routeName: (_) => const TransactionDetails(),
  BillScreen.routeName: (_) => const BillScreen(),
  CreateBillScreen.routeName: (_) => const CreateBillScreen(),
  CreateBillDetailsScreen.routeName: (_) => const CreateBillDetailsScreen(),
  BillDetailsScreen.routeName: (_) => const BillDetailsScreen(),
  AddContractScreen.routeName: (_) => const AddContractScreen(),
  ListContractScreen.routeName: (_) => const ListContractScreen(),
  DetailContractScreen.routeName: (_) => const DetailContractScreen(),
  UpdateBillScreen.routeName: (_) => const UpdateBillScreen(),
};
