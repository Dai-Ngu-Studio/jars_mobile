/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/google.svg
  String get google => 'assets/icons/google.svg';
}

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

  /// File path: assets/images/jars_logo.png
  AssetGenImage get jarsLogo =>
      const AssetGenImage('assets/images/jars_logo.png');

  /// File path: assets/images/wallet.png
  AssetGenImage get wallet => const AssetGenImage('assets/images/wallet.png');

  /// File path: assets/images/wallet_selected.png
  AssetGenImage get walletSelected =>
      const AssetGenImage('assets/images/wallet_selected.png');
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
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
