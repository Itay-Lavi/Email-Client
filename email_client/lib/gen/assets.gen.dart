/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/icons/logo.png');

  /// File path: assets/icons/no-data.png
  AssetGenImage get noData => const AssetGenImage('assets/icons/no-data.png');

  /// File path: assets/icons/no_mail_selected.png
  AssetGenImage get noMailSelected =>
      const AssetGenImage('assets/icons/no_mail_selected.png');

  $AssetsIconsPlatformsGen get platforms => const $AssetsIconsPlatformsGen();

  /// List of all assets
  List<AssetGenImage> get values => [logo, noData, noMailSelected];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/secure_cloud.png
  AssetGenImage get secureCloud =>
      const AssetGenImage('assets/images/secure_cloud.png');

  /// List of all assets
  List<AssetGenImage> get values => [secureCloud];
}

class $AssetsIconsPlatformsGen {
  const $AssetsIconsPlatformsGen();

  /// File path: assets/icons/platforms/apple-icon.png
  AssetGenImage get appleIcon =>
      const AssetGenImage('assets/icons/platforms/apple-icon.png');

  /// File path: assets/icons/platforms/google-icon.png
  AssetGenImage get googleIcon =>
      const AssetGenImage('assets/icons/platforms/google-icon.png');

  /// File path: assets/icons/platforms/outlook-icon.png
  AssetGenImage get outlookIcon =>
      const AssetGenImage('assets/icons/platforms/outlook-icon.png');

  /// File path: assets/icons/platforms/yahoo-icon.png
  AssetGenImage get yahooIcon =>
      const AssetGenImage('assets/icons/platforms/yahoo-icon.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [appleIcon, googleIcon, outlookIcon, yahooIcon];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
