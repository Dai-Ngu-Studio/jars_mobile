import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/screens/home/home_screen.dart';
import 'package:jars_mobile/service/firebase/auth_service.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService googleSignIn = AuthService();

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E3BBA), Color(0xFF5973DD)],
              stops: [0, 100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          Hero(
                            tag: 'SplashScreen',
                            child: Assets.images.jarsLogo.image(
                              width: kIsWeb
                                  ? 200
                                  : MediaQuery.of(context).size.width * 0.25,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Welcome to ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Jars'.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const FittedBox(
                            child: Text(
                              "Get on top of your money, achieve financial goals.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const FittedBox(
                            child: Text(
                              "Enjoy wonderful life and become financially independent.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          googleSignIn.googleLogin().then((value) {
                            Navigator.of(context).pushReplacementNamed(
                              HomeScreen.routeName,
                            );
                          }).catchError(
                            (error) {
                              final snackBar = SnackBar(
                                content: Text(error.toString()),
                                duration: const Duration(seconds: 5),
                              );
                              log(error.toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackBar,
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        icon: SvgPicture.asset(Assets.icons.google, height: 30),
                        label: const Text(
                          "Login with Google",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
