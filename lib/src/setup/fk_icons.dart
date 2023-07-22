import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kickstart/src/interfaces/fk_asset.dart';
import 'package:flutter_kickstart/src/util/fk_toolkit.dart';

import '../widgets/fp_icn.dart';

class FkIcons extends FkAsset {
  FkIcons(super.directory);

  @override
  dynamic noSuchMethod(Invocation invocation) {
    var fileName = FkToolkit.getSymbolName(invocation.memberName);
    var ext = "svg";
    if (fileName.contains("\$")) {
      var split = fileName.split("\$");
      fileName = FkToolkit.camelToUnderscore(split.first);
      ext = split.last.toLowerCase();
    } else {
      fileName = FkToolkit.camelToUnderscore(fileName);
    }
    if (!["png", "svg"].contains(ext)) {
      var message =
          "Icon format $ext is not suported on FkIcons. Suported formats is PNG and SVG.";
      debugPrint(message);
      throw Exception(message);
    }
    final directories = <String>[];
    if (directory is String) {
      directories.add(directory);
    } else if (directory is List<String>) {
      directories.addAll(directory);
    }
    return FpIcon(fileName: "$fileName.$ext", directories: directories);
  }
}

class FkIconsSnippetProvider extends FkIcons implements FkAssetSnippetProvider {
  FkIconsSnippetProvider() : super("");
  @override
  void setDirectory(dynamic value) {
    super.directory = value;
  }
}

class FkDynamicIcons extends FkIcons {
  FkDynamicIcons(super.directory);
  @override
  Widget noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation).toIcon();
  }
}

class FpIcon {
  final List<String> fileNames = [];
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final List<String> directories;

  FpIcon({
    required String fileName,
    required this.directories,
    this.width,
    this.height,
    this.fit,
    this.color,
  }) {
    for (var directory in directories) {
      fileNames.add("${FkToolkit.formatInputedDirectory(directory)}/$fileName");
    }
  }

  Future<({Uint8List bytes, FpIconType type})> _loadAssetFromIndex(
      int index) async {
    ByteData data;
    var fileName = fileNames[index];
    try {
      data = await rootBundle.load(fileName);
    } catch (e) {
      if (fileNames.length == index + 1) {
        throw Exception("Icon with name $fileName not found!");
      } else {
        index = index + 1;
        return _loadAssetFromIndex(index);
      }
    }
    var result = data.buffer.asUint8List();
    var type = fileName.contains(".svg") ? FpIconType.svg : FpIconType.png;
    return (bytes: result, type: type);
  }

  Widget toIcon({double? width, double? height, BoxFit? fit, Color? color}) {
    if (directories.isEmpty) {
      var message =
          "Unable to load icon, iconsDirectory not given on FkTheme creation";
      debugPrint(message);
      throw Exception(message);
    }

    return FutureBuilder<({Uint8List bytes, FpIconType type})>(
        future: _loadAssetFromIndex(0),
        builder: (_, snapshot) {
          return snapshot.hasData
              ? FpIcn.memory(
                  fit: fit ?? (this.fit ?? BoxFit.contain),
                  width: width ?? this.width,
                  height: height ?? this.height,
                  color: color ?? this.color,
                  bytes: snapshot.data!.bytes,
                  fpIconType: snapshot.data!.type,
                )
              : SizedBox(
                  height: width ?? this.width,
                  width: height ?? this.height,
                );
        });
  }
}
