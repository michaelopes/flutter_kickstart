import 'package:flutter/material.dart';
import 'package:flutter_kickstart/src/interfaces/fk_asset.dart';
import 'fk_globals.dart' as globals;
import '../util/toolkit.dart';

class FkImages extends FkAsset {
  @override
  T? tryGet<T>() {
    try {
      return FkImages() as T;
    } catch (e) {
      return null;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    var fileName = Toolkit.getSymbolName(invocation.memberName);

    var ext = "png";
    if (fileName.contains("\$")) {
      var split = fileName.split("\$");
      fileName = Toolkit.camelToUnderscore(split.first);
      ext = split.last.toLowerCase();
    } else {
      fileName = Toolkit.camelToUnderscore(fileName);
    }
    if (!["png", "jpg", "jpeg"].contains(ext)) {
      var message =
          "Image format $ext is not suported on FkImages. Suported formats is PNG, JPG and JPEG.";
      debugPrint(message);
      throw Exception(message);
    }
    return FpImage(fileName: "$fileName.$ext");
  }
}

class FkDynamicImages extends FkImages {
  @override
  Widget noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation).toImage();
  }
}

class FpImage {
  late final String fileName;
  final double? width;
  final double? height;
  final BoxFit? fit;

  FpImage({
    required String fileName,
    this.width,
    this.height,
    this.fit,
  }) {
    this.fileName =
        "${Toolkit.formatInputedDirectory(globals.imagesDirectory)}/$fileName";
  }

  Image toImage({double? width, double? height, BoxFit? fit}) {
    if (globals.imagesDirectory.isEmpty) {
      var message =
          "Unable to load image, imagesDirectory not given at Fk.init";
      debugPrint(message);
      throw Exception(message);
    }
    return Image.asset(
      fileName,
      fit: fit ?? (this.fit ?? BoxFit.contain),
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}
