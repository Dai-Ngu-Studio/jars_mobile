import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillDetailsBox extends StatelessWidget {
  const BillDetailsBox({
    Key? key,
    required this.name,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  final String name;
  final num quantity;
  final num price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${quantity.toString()}x ' +
                      NumberFormat.currency(
                        locale: 'vi_VN',
                        decimalDigits: 0,
                        symbol: 'đ',
                      ).format(price),
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
    );
  }
}
