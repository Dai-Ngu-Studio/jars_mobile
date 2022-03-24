import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/screens/add_transaction/components/add_transaction_expense.dart';
import 'package:jars_mobile/views/screens/add_transaction/components/add_transaction_income.dart';
import 'package:jars_mobile/views/screens/add_transaction/components/add_transaction_move_money.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class AddTransactionBody extends StatefulWidget {
  const AddTransactionBody({Key? key, this.tabIndex}) : super(key: key);

  final int? tabIndex;

  @override
  State<AddTransactionBody> createState() => _AddTransactionBodyState();
}

class _AddTransactionBodyState extends State<AddTransactionBody>
    with SingleTickerProviderStateMixin {
  final _walletVM = WalletViewModel();
  final _firebaseAuth = FirebaseAuth.instance;
  late final TabController _controller;
  List wallets = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.tabIndex!,
    );

    _firebaseAuth.currentUser!.getIdToken().then((idToken) async {
      var wallets = await _walletVM.getWallets(
        idToken: idToken,
      );
      setState(() {
        this.wallets = wallets;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = _controller.index == 0
        ? Colors.green
        : _controller.index == 1
            ? Colors.red
            : jarsColor;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Material(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(50),
              child: TabBar(
                tabs: const [
                  Tab(text: "INCOME"),
                  Tab(text: "EXPENSE"),
                ],
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                controller: _controller,
                onTap: (index) {
                  setState(() {
                    color = _controller.index == 0
                        ? Colors.green
                        : _controller.index == 1
                            ? Colors.red
                            : jarsColor;
                  });
                },
                indicator: RectangularIndicator(
                  bottomLeftRadius: 100,
                  bottomRightRadius: 100,
                  topLeftRadius: 100,
                  topRightRadius: 100,
                  color: color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                const AddTransactionIncome(),
                AddTransactionExpense(wallets: wallets),
                // AddTransactionMoveMoney(jars: jars),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
