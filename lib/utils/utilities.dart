import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jars_mobile/constants/colors.dart';
import 'package:jars_mobile/gen/assets.gen.dart';

class Utilities {
  static String getJarImageByName(String jarName) {
    switch (jarName) {
      case 'Necessities':
        return Assets.svgs.jarNecessities.path;
      case 'Education':
        return Assets.svgs.jarEducation.path;
      case 'Saving':
        return Assets.svgs.jarSaving.path;
      case 'Play':
        return Assets.svgs.jarPlay.path;
      case 'Investment':
        return Assets.svgs.jarInvestment.path;
      case 'Give':
        return Assets.svgs.jarGive.path;
      default:
        return Assets.svgs.jarNecessities.path;
    }
  }

  static Color getJarColorByName(String jarName) {
    switch (jarName) {
      case 'Necessities':
        return kNecessitiesColor;
      case 'Education':
        return kEducationColor;
      case 'Saving':
        return kSavingColor;
      case 'Play':
        return kPlayColor;
      case 'Investment':
        return kInvestmentColor;
      case 'Give':
        return kGiveColor;
      default:
        return jarsColor;
    }
  }

  static int getWeekNumberOfYear(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }
}
