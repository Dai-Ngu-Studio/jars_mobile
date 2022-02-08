import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final firebaseAuth = FirebaseAuth.instance;
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return;

    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    print(googleAuth.accessToken);
    print(googleAuth.idToken);

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print(credential.accessToken);
    print(credential.idToken);

    await firebaseAuth.signInWithCredential(credential);

    final currentUser = firebaseAuth.currentUser;
    currentUser?.getIdToken().then((value) => print(value));
  }
}
