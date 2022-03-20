import 'package:flutter/material.dart';
import 'package:jars_mobile/constant.dart';
import 'package:jars_mobile/views/add_transaction/components/add_transaction_expense.dart';
import 'package:jars_mobile/views/add_transaction/components/add_transaction_income.dart';
import 'package:jars_mobile/views/add_transaction/components/add_transaction_move_money.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class AddTransactionBody extends StatefulWidget {
  const AddTransactionBody({Key? key, this.tabIndex}) : super(key: key);

  final int? tabIndex;

  @override
  State<AddTransactionBody> createState() => _AddTransactionBodyState();
}

class _AddTransactionBodyState extends State<AddTransactionBody>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  List jars = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.tabIndex ?? 1,
    );

    jars = [
      {
        'jarName': 'Necessities',
        'id': '1',
        'amount': '8600000',
      },
      {
        'jarName': 'Education',
        'id': '2',
        'amount': '1200000',
      },
      {
        'jarName': 'Saving',
        'id': '3',
        'amount': '1200000',
      },
      {
        'jarName': 'Play',
        'id': '4',
        'amount': '1200000',
      },
      {
        'jarName': 'Investment',
        'id': '5',
        'amount': '1200000',
      },
      {
        'jarName': 'Give',
        'id': '5',
        'amount': '900000',
      },
    ];
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
                  Tab(text: "MOVE MONEY"),
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
                AddTransactionExpense(jars: jars),
                AddTransactionMoveMoney(jars: jars),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
