import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final directories = <String>[];
    if (directory is String) {
      directories.add(directory);
    } else if (directory is List<String>) {
      directories.addAll(directory);
    }

    return FpAnimation(fileName: "$fileName.$ext", directories: directories);
  }
}

class FkAnimationsSnippetProvider extends FkAnimations
    implements FkAssetSnippetProvider {
  FkAnimationsSnippetProvider() : super("");
  @override
  void setDirectory(dynamic value) {
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
  final List<String> fileNames = [];
  final double? width;
  final double? height;
  final BoxFit? fit;
  final List<String> directories;
  FpAnimation({
    required String fileName,
    required this.directories,
    this.width,
    this.height,
    this.fit,
  }) {
    for (var directory in directories) {
      fileNames.add("${FkToolkit.formatInputedDirectory(directory)}/$fileName");
    }
  }

  Future<Uint8List> _loadAssetFromIndex(int index) async {
    ByteData data;
    var fileName = fileNames[index];
    try {
      data = await rootBundle.load(fileName);
    } catch (e) {
      if (fileNames.length == index + 1) {
        throw Exception("Animation with name $fileName not found!");
      } else {
        index = index + 1;
        return _loadAssetFromIndex(index);
      }
    }
    return data.buffer.asUint8List();
  }

  Widget toAnimation({
    Animation<double>? controller,
    void Function(Duration)? onLoaded,
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    if (directories.isEmpty) {
      var message =
          "Unable to load animation, animationsDirectory not given on FkTheme creation";
      debugPrint(message);
      throw Exception(message);
    }
    return FutureBuilder<Uint8List>(
        future: _loadAssetFromIndex(0),
        builder: (_, snapshot) {
          return snapshot.hasData
              ? Lottie.memory(
                  snapshot.data!,
                  width: width ?? this.width,
                  height: height ?? this.height,
                  fit: fit ?? (this.fit ?? BoxFit.contain),
                  controller: controller,
                  onLoaded: (composition) =>
                      onLoaded?.call(composition.duration),
                )
              : SizedBox(
                  height: width ?? this.width,
                  width: height ?? this.height,
                );
        });
  }
}
