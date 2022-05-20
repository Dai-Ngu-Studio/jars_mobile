import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final String msg;

  const ErrorWidget(this.msg, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(msg));
  }
}
