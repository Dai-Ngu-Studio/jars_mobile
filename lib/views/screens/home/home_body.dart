import 'package:flutter/material.dart';
import 'package:jars_mobile/service/firebase/auth_service.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();

    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () => _auth.signOut(context: context).catchError((err) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(err.toString())),
            );
          }),
          child: Text('Log out'),
        ),
      ),
    );
  }
}
