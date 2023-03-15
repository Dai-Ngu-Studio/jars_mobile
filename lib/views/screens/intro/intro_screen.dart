import 'package:flutter/material.dart';
import 'package:jars_mobile/constants/colors.dart';
import 'package:jars_mobile/data/local/shared_prefs_helper.dart';
import 'package:jars_mobile/view_model/account_view_model.dart';
import 'package:jars_mobile/view_model/wallet_view_model.dart';
import 'package:jars_mobile/views/screens/intro/components/auto_split_view.dart';
import 'package:jars_mobile/views/screens/intro/components/back_skip_widget.dart';
import 'package:jars_mobile/views/screens/intro/components/begin_view.dart';
import 'package:jars_mobile/views/screens/intro/components/next_login_button.dart';
import 'package:jars_mobile/views/screens/intro/components/six_jars_principle_view.dart';
import 'package:jars_mobile/views/screens/intro/components/use_app_time_view.dart';
import 'package:jars_mobile/views/screens/intro/components/welcome_view.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with TickerProviderStateMixin {
  late AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 6));
    _animationController?.animateTo(0.0);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: jarsColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E3BBA), Color(0xFF5973DD)],
            stops: [0, 100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ClipRect(
          child: Stack(
            children: [
              BeginScreen(animationController: _animationController!),
              UseAppTimeView(animationController: _animationController!),
              SixJarsPrincipleView(animationController: _animationController!),
              AutoSplitView(animationController: _animationController!),
              WelcomeView(animationController: _animationController!),
              BackSkipWidget(
                onBackClick: _onBackClick,
                onSkipClick: _onSkipClick,
                animationController: _animationController!,
              ),
              CenterNextButton(
                animationController: _animationController!,
                onNextClick: _onNextClick,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8, duration: const Duration(milliseconds: 1000));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 && _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 && _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 && _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 && _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 && _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  Future _onNextClick() async {
    if (_animationController!.value >= 0 && _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 && _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 && _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 && _animationController!.value <= 0.8) {
      return await _login();
    }
  }

  Future<bool> _login() async {
    final accountVM = Provider.of<AccountViewModel>(
      context,
      listen: false,
    );

    final loginResult = await accountVM.login();

    if (!loginResult) return false;

    final genSixJarsResult = await Provider.of<WalletViewModel>(
      context,
      listen: false,
    ).generateSixJars(idToken: (await accountVM.idToken)!);

    if (!genSixJarsResult) return false;

    SharedPrefsHelper.set(key: "isSkipIntro", value: "true");
    return true;
  }
}
