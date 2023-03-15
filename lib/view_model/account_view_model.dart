import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jars_mobile/data/models/account.dart';
import 'package:jars_mobile/data/remote/response/api_response.dart';
import 'package:jars_mobile/data/repository/account_repository_impl.dart';

class AccountViewModel extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  final _accountRepo = AccountRepositoryImpl();
  GoogleSignInAccount? _googleUser;

  ApiResponse<Account> account = ApiResponse.loading();

  GoogleSignInAccount get googleUser => _googleUser!;

  bool get isAuth {
    return _firebaseAuth.currentUser != null;
  }

  Future<String?> get idToken async {
    return await _firebaseAuth.currentUser?.getIdToken();
  }

  Future<String?> get fcmToken async {
    return await FirebaseMessaging.instance.getToken();
  }

  User? get user => _firebaseAuth.currentUser;

  void _setAccount(ApiResponse<Account> response) {
    log(response.toString());
    account = response;
  }

  Future<bool> login() async {
    try {
      final isAuth = await _loginGoogle();

      if (!isAuth) {
        _setAccount(ApiResponse.error("Login failed"));
        return false;
      }

      _setAccount(ApiResponse.loading());

      var user = await _accountRepo.login(idToken: (await idToken)!, fcmToken: await fcmToken);

      _setAccount(ApiResponse.completed(user));

      return true;
    } catch (e) {
      _setAccount(ApiResponse.error(e.toString()));
      rethrow;
    }
  }

  Future<bool> _loginGoogle() async {
    final googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      await logout();

      final googleAccount = await googleSignIn.signIn();

      if (googleAccount == null) return false;

      _googleUser = googleAccount;

      final googleAuth = await googleAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);

      log((await idToken)!);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw Exception('This email already has an account');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Invalid Credential');
      } else if (e.code == 'user-disabled') {
        throw Exception('User Disabled');
      }
    } catch (_) {
      rethrow;
    }

    return false;
  }

  Future<void> logout() async {
    final googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (_) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
