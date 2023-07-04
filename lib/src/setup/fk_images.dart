import 'package:flutter/material.dart';
import 'package:flutter_kickstart/src/interfaces/fk_asset.dart';
import '../util/fk_toolkit.dart';

class FkImages extends FkAsset {
  FkImages(super.directory);

  @override
  dynamic noSuchMethod(Invocation invocation) {
    var fileName = FkToolkit.getSymbolName(invocation.memberName);

    var ext = "png";
    if (fileName.contains("\$")) {
      var split = fileName.split("\$");
      fileName = FkToolkit.camelToUnderscore(split.first);
      ext = split.last.toLowerCase();
    } else {
      fileName = FkToolkit.camelToUnderscore(fileName);
    }
    if (!["png", "jpg", "jpeg"].contains(ext)) {
      var message =
          "Image format $ext is not suported on FkImages. Suported formats is PNG, JPG and JPEG.";
      debugPrint(message);
      throw Exception(message);
    }
    return FpImage(fileName: "$fileName.$ext", directory: directory);
  }
}

class FkImagesSnippetProvider extends FkImages
    implements FkAssetSnippetProvider {
  FkImagesSnippetProvider() : super("");
  @override
  void setDirectory(String value) {
    super.directory = value;
  }
}

class FkDynamicImages extends FkImages {
  FkDynamicImages(super.directory);

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
  final String directory;

  FpImage({
    required String fileName,
    this.width,
    this.height,
    this.fit,
    required this.directory,
  }) {
    this.fileName = "${FkToolkit.formatInputedDirectory(directory)}/$fileName";
  }

  Image toImage({double? width, double? height, BoxFit? fit}) {
    if (directory.isEmpty) {
      var message =
          "Unable to load image, imagesDirectory not given on FkTheme creation";
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
