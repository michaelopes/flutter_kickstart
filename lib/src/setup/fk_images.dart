import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    final directories = <String>[];
    if (directory is String) {
      directories.add(directory);
    } else if (directory is List<String>) {
      directories.addAll(directory);
    }
    return FpImage(fileName: "$fileName.$ext", directories: directories);
  }
}

class FkImagesSnippetProvider extends FkImages
    implements FkAssetSnippetProvider {
  FkImagesSnippetProvider() : super("");
  @override
  void setDirectory(dynamic value) {
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
  final List<String> fileNames = [];
  final double? width;
  final double? height;
  final BoxFit? fit;
  final List<String> directories;

  FpImage({
    required String fileName,
    this.width,
    this.height,
    this.fit,
    required this.directories,
  }) {
    for (var directory in directories) {
      fileNames.add("${FkToolkit.formatInputedDirectory(directory)}/$fileName");
    }
  }

  Widget toImage({double? width, double? height, BoxFit? fit}) {
    if (directories.isEmpty) {
      var message =
          "Unable to load image, imagesDirectory not given on FkTheme creation";
      debugPrint(message);
      throw Exception(message);
    }

    return _ImageAssetLoader(
      fileNames: fileNames,
      fit: fit ?? (this.fit ?? BoxFit.contain),
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}

class _ImageAssetLoader extends StatefulWidget {
  final List<String> fileNames;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const _ImageAssetLoader({
    Key? key,
    required this.fileNames,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  @override
  State<_ImageAssetLoader> createState() => __ImageAssetLoaderState();
}

class __ImageAssetLoaderState extends State<_ImageAssetLoader> {
  Uint8List? _bytes;
  Brightness? _currentBrightness;

  List<String> get fileNames => widget.fileNames;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    var bts = await _loadAssetFromIndex(0);
    if (mounted) {
      _currentBrightness = Theme.of(context).brightness;
      setState(() {
        _bytes = bts;
      });
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    FkToolkit.when(() => mounted, () {
      if (_currentBrightness != Theme.of(context).brightness) {
        _setup();
      }
    }, 50);
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

  @override
  Widget build(BuildContext context) {
    return _bytes != null
        ? Image.memory(
            _bytes!,
            fit: widget.fit,
            width: widget.width,
            height: widget.height,
          )
        : SizedBox(
            height: widget.width,
            width: widget.height,
          );
  }
}
