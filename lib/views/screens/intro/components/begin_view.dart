import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class BeginScreen extends StatefulWidget {
  final AnimationController animationController;

  const BeginScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  _BeginScreenState createState() => _BeginScreenState();
}

class _BeginScreenState extends State<BeginScreen> {
  final _privacyPolicyUrl = "https://jars-c19f8.web.app/privacy-policy";

  @override
  Widget build(BuildContext context) {
    final _introductionanimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0.0, -1.0),
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.0, 0.2, curve: Curves.fastOutSlowIn),
      ),
    );
    return SlideTransition(
      position: _introductionanimation,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Assets.images.introBegin.image(
                width: kIsWeb ? 400 : MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.cover,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 36.0, bottom: 8.0),
                child: Text(
                  "JARS",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "An intuitive and incredible simple way to manage your personal finaces.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text:
                              "By continuing, you confirm that you have read and agree to the ",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        WidgetSpan(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _launchURL(),
                              child: const Text(
                                "Privacy and Policy",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 16,
                    ),
                    child: InkWell(
                      onTap: () {
                        widget.animationController.animateTo(0.2);
                      },
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.only(
                          left: 56.0,
                          right: 56.0,
                          top: 14,
                          bottom: 14,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38.0),
                          color: const Color(0xff1a1b50),
                        ),
                        child: const Text(
                          "Let's begin",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL() async {
    if (!await launch(_privacyPolicyUrl)) {
      throw 'Could not launch $_privacyPolicyUrl';
    }
  }
}
