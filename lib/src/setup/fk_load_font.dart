import 'dart:typed_data';

import 'package:flutter/services.dart';

import '../model/fk_font.dart';

class FpLoadFont {
  static Future<void> run(FkFont font) async {
    ByteBuffer buffer = await _AssetBundle().loadByteBuffer(font.path);
    var data = ByteData.view(buffer);
    var custom = FontLoader(font.name);
    custom.addFont(Future(() => data));
    await custom.load();
  }
}

class _AssetBundle extends CachingAssetBundle {
  Future<ByteBuffer> loadByteBuffer(String key, {bool cache = true}) async {
    final data = await load(key);
    return data.buffer;
  }

  @override
  Future<ByteData> load(String key) async => rootBundle.load(key);
}
