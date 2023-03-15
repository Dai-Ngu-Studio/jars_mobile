import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:jars_mobile/constants/colors.dart';
import 'package:jars_mobile/gen/assets.gen.dart';
import 'package:jars_mobile/view_model/account_view_model.dart';
import 'package:jars_mobile/views/screens/add_contract/view_contracts.dart';
import 'package:jars_mobile/views/screens/bill/bill_screen.dart';
import 'package:jars_mobile/views/screens/create_bill/create_bill_screen.dart';
import 'package:jars_mobile/views/screens/login/login_screen.dart';
import 'package:jars_mobile/views/screens/settings/components/setting_menu.dart';
import 'package:jars_mobile/views/screens/settings/components/user_box.dart';
import 'package:provider/provider.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> with TickerProviderStateMixin {
  List<Widget> listViews = [];

  @override
  void initState() {
    addAllListData();
    super.initState();
  }

  void addAllListData() {
    const int count = 6;

    listViews.add(
      UserBox(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
      ),
    );

    // listViews.add(
    //   SettingMenu(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //       CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve: const Interval(
    //           (1 / count) * 1,
    //           1.0,
    //           curve: Curves.fastOutSlowIn,
    //         ),
    //       ),
    //     ),
    //     animationController: widget.animationController!,
    //     icon: const Icon(Icons.grid_view_rounded, size: 18),
    //     text: "General Settings",
    //     onPressed: () {
    //       Navigator.of(context).pushNamed(
    //         GeneralSettingsScreen.routeName,
    //         arguments: GeneralSttingsArguments(
    //           animationController: widget.animationController,
    //         ),
    //       );
    //     },
    //   ),
    // );

    listViews.add(
      SettingMenu(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
        text: "Bill",
        onPressed: () => Navigator.of(context).pushNamed(BillScreen.routeName),
      ),
    );

    listViews.add(
      SettingMenu(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
        text: "Create Bill",
        onPressed: () => Navigator.of(context).pushNamed(CreateBillScreen.routeName),
      ),
    );

    listViews.add(
      SettingMenu(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
        text: "View Contract",
        onPressed: () => Navigator.of(context).pushNamed(ListContractScreen.routeName),
        iconNext: true,
      ),
    );

    listViews.add(const SizedBox(height: 24));

    // listViews.add(
    //   SettingMenu(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //       CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve: const Interval(
    //           (1 / count) * 3,
    //           1.0,
    //           curve: Curves.fastOutSlowIn,
    //         ),
    //       ),
    //     ),
    //     animationController: widget.animationController!,
    //     icon: Assets.svgs.excel.svg(width: 18),
    //     text: "Export Excel",
    //     onPressed: () {},
    //     iconNext: false,
    //   ),
    // );

    listViews.add(
      SettingMenu(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
        icon: const Icon(Icons.mail_rounded, size: 18),
        text: "Feedback",
        onPressed: () async {
          final Email email = Email(
            subject: 'Feedback JARS app',
            recipients: ['neodymium.ndungx@gmail.com'],
          );
          await FlutterEmailSender.send(email);
        },
        iconNext: false,
      ),
    );

    listViews.add(
      SettingMenu(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
        icon: const Icon(Icons.info, size: 18),
        text: "App Infomation",
        iconNext: false,
        onPressed: () async {
          showAboutDialog(
            context: context,
            applicationName: 'JARS',
            applicationIcon: Assets.images.jarsLogo.image(width: 75),
            applicationVersion: '1.0.0',
            applicationLegalese: '© 2022 JARS',
            routeSettings: const RouteSettings(name: 'about'),
            children: [
              const SizedBox(height: 16),
              const Text(
                'JARS: financial planning, review, expense tracking, and personal asset management app.',
              ),
              const SizedBox(height: 4),
              Text('User ID: ${Provider.of<AccountViewModel>(context, listen: false).user!.uid}'),
              const SizedBox(height: 16),
              const Text('Copyright © 2022 JARS. All rights reserved.'),
            ],
          );
        },
      ),
    );

    listViews.add(
      SettingMenu(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn),
          ),
        ),
        animationController: widget.animationController!,
        icon: const Icon(Icons.logout, size: 18),
        text: "Log out",
        onPressed: () async {
          await Provider.of<AccountViewModel>(context, listen: false).logout();
          final navigator = Navigator.of(context);
          navigator.popUntil((route) => route.isFirst);
          navigator.pushReplacementNamed(LoginScreen.routeName);
        },
        iconNext: false,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kBackgroundColor,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              getMainListViewUI(),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong! Please try again later."),
          );
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }
}
