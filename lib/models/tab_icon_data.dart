import 'package:flutter/material.dart';
import 'package:jars_mobile/gen/assets.gen.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: Assets.images.home.path,
      selectedImagePath: Assets.images.homeSelected.path,
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: Assets.images.wallet.path,
      selectedImagePath: Assets.images.walletSelected.path,
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: Assets.images.analysis.path,
      selectedImagePath: Assets.images.analysisSelected.path,
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: Assets.images.account.path,
      selectedImagePath: Assets.images.accountSelected.path,
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
