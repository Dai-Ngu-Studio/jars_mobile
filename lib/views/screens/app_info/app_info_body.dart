import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jars_mobile/gen/assets.gen.dart';

class AppInfoBody extends StatelessWidget {
  const AppInfoBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60)),
              child: Assets.images.jarsLogo.image(),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "JARS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          const Text("Version 1.0.0", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Text("User ID: ${FirebaseAuth.instance.currentUser!.uid}")
        ],
      ),
    );
  }
}
