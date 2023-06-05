import 'package:flutter/material.dart';
import 'package:flutter_kickstart/src/interfaces/fk_asset.dart';
import 'package:lottie/lottie.dart';

import '../util/toolkit.dart';
import 'fk_globals.dart' as globals;

class FkAnimations extends FkAsset {
  @override
  T? tryGet<T>() {
    try {
      return FkAnimations() as T;
    } catch (e) {
      return null;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    var fileName = Toolkit.getSymbolName(invocation.memberName);
    var ext = "json";
    if (fileName.contains("\$")) {
      var split = fileName.split("\$");
      fileName = Toolkit.camelToUnderscore(split.first);
      ext = split.last.toLowerCase();
    } else {
      fileName = Toolkit.camelToUnderscore(fileName);
    }
    if (!["json"].contains(ext)) {
      var message =
          "Animation  format $ext is not suported on FkAnimations. Suported formats is PNG and SVG.";
      debugPrint(message);
      throw Exception(message);
    }
    return FpAnimation(fileName: "$fileName.$ext");
  }
}

class FkDynamicAnimations extends FkAnimations {
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
  FpAnimation({
    required String fileName,
    this.width,
    this.height,
    this.fit,
  }) {
    this.fileName =
        "${Toolkit.formatInputedDirectory(globals.animationsDirectory)}/$fileName";
  }

  Widget toAnimation({
    Animation<double>? controller,
    void Function(Duration)? onLoaded,
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    if (globals.animationsDirectory.isEmpty) {
      var message =
          "Unable to load animation, animationsDirectory not given at Fk.init";
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
