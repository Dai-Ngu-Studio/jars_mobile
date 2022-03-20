/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/account.png
  AssetGenImage get account => const AssetGenImage('assets/images/account.png');

  /// File path: assets/images/account_selected.png
  AssetGenImage get accountSelected =>
      const AssetGenImage('assets/images/account_selected.png');

  /// File path: assets/images/analysis.png
  AssetGenImage get analysis =>
      const AssetGenImage('assets/images/analysis.png');

  /// File path: assets/images/analysis_selected.png
  AssetGenImage get analysisSelected =>
      const AssetGenImage('assets/images/analysis_selected.png');

  /// File path: assets/images/home.png
  AssetGenImage get home => const AssetGenImage('assets/images/home.png');

  /// File path: assets/images/home_selected.png
  AssetGenImage get homeSelected =>
      const AssetGenImage('assets/images/home_selected.png');

  /// File path: assets/images/intro_begin.png
  AssetGenImage get introBegin =>
      const AssetGenImage('assets/images/intro_begin.png');

  /// File path: assets/images/jar.png
  AssetGenImage get jar => const AssetGenImage('assets/images/jar.png');

  /// File path: assets/images/jar_selected.png
  AssetGenImage get jarSelected =>
      const AssetGenImage('assets/images/jar_selected.png');

  /// File path: assets/images/jars_logo.png
  AssetGenImage get jarsLogo =>
      const AssetGenImage('assets/images/jars_logo.png');
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/auto_split.svg
  SvgGenImage get autoSplit => const SvgGenImage('assets/svgs/auto_split.svg');

  /// File path: assets/svgs/excel.svg
  SvgGenImage get excel => const SvgGenImage('assets/svgs/excel.svg');

  /// File path: assets/svgs/google.svg
  SvgGenImage get google => const SvgGenImage('assets/svgs/google.svg');

  /// File path: assets/svgs/jar.svg
  SvgGenImage get jar => const SvgGenImage('assets/svgs/jar.svg');

  /// File path: assets/svgs/jar_education.svg
  SvgGenImage get jarEducation =>
      const SvgGenImage('assets/svgs/jar_education.svg');

  /// File path: assets/svgs/jar_give.svg
  SvgGenImage get jarGive => const SvgGenImage('assets/svgs/jar_give.svg');

  /// File path: assets/svgs/jar_investment.svg
  SvgGenImage get jarInvestment =>
      const SvgGenImage('assets/svgs/jar_investment.svg');

  /// File path: assets/svgs/jar_necessities.svg
  SvgGenImage get jarNecessities =>
      const SvgGenImage('assets/svgs/jar_necessities.svg');

  /// File path: assets/svgs/jar_play.svg
  SvgGenImage get jarPlay => const SvgGenImage('assets/svgs/jar_play.svg');

  /// File path: assets/svgs/jar_saving.svg
  SvgGenImage get jarSaving => const SvgGenImage('assets/svgs/jar_saving.svg');

  /// File path: assets/svgs/six_jars_principle.svg
  SvgGenImage get sixJarsPrinciple =>
      const SvgGenImage('assets/svgs/six_jars_principle.svg');

  /// File path: assets/svgs/use_app_time.svg
  SvgGenImage get useAppTime =>
      const SvgGenImage('assets/svgs/use_app_time.svg');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
