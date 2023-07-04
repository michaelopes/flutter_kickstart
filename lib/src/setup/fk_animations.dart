import 'package:flutter/material.dart';
import 'package:flutter_kickstart/src/interfaces/fk_asset.dart';
import 'package:lottie/lottie.dart';

import '../util/fk_toolkit.dart';

class FkAnimations extends FkAsset {
  FkAnimations(super.directory);

  @override
  dynamic noSuchMethod(Invocation invocation) {
    var fileName = FkToolkit.getSymbolName(invocation.memberName);
    var ext = "json";
    if (fileName.contains("\$")) {
      var split = fileName.split("\$");
      fileName = FkToolkit.camelToUnderscore(split.first);
      ext = split.last.toLowerCase();
    } else {
      fileName = FkToolkit.camelToUnderscore(fileName);
    }
    if (!["json"].contains(ext)) {
      var message =
          "Animation  format $ext is not suported on FkAnimations. Suported formats is PNG and SVG.";
      debugPrint(message);
      throw Exception(message);
    }
    return FpAnimation(fileName: "$fileName.$ext", directory: directory);
  }
}

class FkAnimationsSnippetProvider extends FkAnimations
    implements FkAssetSnippetProvider {
  FkAnimationsSnippetProvider() : super("");
  @override
  void setDirectory(String value) {
    super.directory = value;
  }
}

class FkDynamicAnimations extends FkAnimations {
  FkDynamicAnimations(super.directory);

  @override
  Widget noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation).toAnimation();
  }
}

class FpAnimation {
  late final String fileName;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String directory;
  FpAnimation({
    required String fileName,
    required this.directory,
    this.width,
    this.height,
    this.fit,
  }) {
    this.fileName = "${FkToolkit.formatInputedDirectory(directory)}/$fileName";
  }

  Widget toAnimation({
    Animation<double>? controller,
    void Function(Duration)? onLoaded,
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    if (directory.isEmpty) {
      var message =
          "Unable to load animation, animationsDirectory not given on FkTheme creation";
      debugPrint(message);
      throw Exception(message);
    }
    return Lottie.asset(
      fileName,
      width: width ?? this.width,
      height: height ?? this.height,
      fit: fit ?? (this.fit ?? BoxFit.contain),
      controller: controller,
      onLoaded: (composition) => onLoaded?.call(composition.duration),
    );
  }
}
