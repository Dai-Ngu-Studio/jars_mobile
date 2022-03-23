import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/views/screens/bill_details/bill_details_screen.dart';

class BillBox extends StatelessWidget {
  const BillBox({
    Key? key,
    required this.billId,
    required this.name,
    required this.date,
    required this.leftAmount,
    required this.amount,
  }) : super(key: key);

  final int billId;
  final String name;
  final String date;
  final num leftAmount;
  final num amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            BillDetailsScreen.routeName,
            arguments: BillDetailsScreenArguments(billId: billId),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Name: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: name),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Date: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: DateFormat('dd/MM/yyyy')
                              .format(DateTime.parse(date)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "$leftAmount"),
                    const TextSpan(text: "/"),
                    TextSpan(
                      text: NumberFormat.currency(locale: 'vi_VN', symbol: "đ")
                          .format(amount),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
