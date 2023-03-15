import 'package:flutter/material.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';

class FactoryResetBody extends StatefulWidget {
  const FactoryResetBody({Key? key}) : super(key: key);

  @override
  State<FactoryResetBody> createState() => _FactoryResetBodyState();
}

class _FactoryResetBodyState extends State<FactoryResetBody> {
  bool _isValidate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('If you choose Reset, all of your records will be cleared. Be sure: '),
          const SizedBox(height: 36),
          RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(text: 'Step 1: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Enter the word '),
                TextSpan(text: '"CONFIRM"', style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 45,
            child: TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
              onChanged: (value) => setState(() => _isValidate = value == 'CONFIRM'),
            ),
          ),
          const SizedBox(height: 36),
          RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(text: 'Step 2: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Click the button bellow'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          AdaptiveButton(
            text: "Reset",
            enabled: _isValidate,
            backgroundColor: Colors.red,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
