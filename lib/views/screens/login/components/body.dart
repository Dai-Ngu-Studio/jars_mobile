import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/data/local/shared_prefs_helper.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/view_model/account_view_model.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/screens/app/app.dart';
import 'package:jars_mobile/views/widgets/adaptive_button.dart';
import 'package:jars_mobile/views/widgets/show_dialog.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
                              width: kIsWeb ? 200 : MediaQuery.of(context).size.width * 0.25,
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
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const FittedBox(
                            child: Text(
                              "Get on top of your money, achieve financial goals.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const FittedBox(
                            child: Text(
                              "Enjoy wonderful life and become financially independent.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: AdaptiveButton(
                          text: "Login with Google",
                          enabled: !_isLoading,
                          icon: Assets.svgs.google.svg(height: 30),
                          widthWeb: MediaQuery.of(context).size.width < 800
                              ? MediaQuery.of(context).size.width * 0.8
                              : MediaQuery.of(context).size.width * 0.5,
                          height: 45,
                          borderRadius: 40,
                          backgroundColor: Colors.white,
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          isLoading: _isLoading,
                          onPressed: () async {
                            try {
                              setState(() => _isLoading = true);

                              final accountVM = Provider.of<AccountViewModel>(
                                context,
                                listen: false,
                              );

                              final loginResult = await accountVM.login();

                              if (loginResult) {
                                final genSixJarsResult = await Provider.of<WalletViewModel>(
                                  context,
                                  listen: false,
                                ).generateSixJars(idToken: (await accountVM.idToken)!);

                                if (genSixJarsResult) {
                                  SharedPrefsHelper.set(key: "isSkipIntro", value: "true");
                                  Navigator.of(context).pushReplacementNamed(JarsApp.routeName);
                                }
                              } else {
                                setState(() => _isLoading = false);
                              }
                            } catch (e) {
                              setState(() => _isLoading = false);
                              showErrorDialog(context: context, message: e.toString());
                            }
                          },
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
