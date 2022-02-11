import 'package:flutter/material.dart';
import 'package:jars_mobile/service/firebase/auth_service.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();

    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () => _auth.signOut(context),
          child: Text('Log out'),
        ),
      ),
    );
  }
}
