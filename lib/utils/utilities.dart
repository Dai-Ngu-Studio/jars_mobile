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
}
