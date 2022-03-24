import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(8),
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
                const TextSpan(
                  text: "Name: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: name),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Price: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: price.toString()),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Quantity: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: quantity.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
