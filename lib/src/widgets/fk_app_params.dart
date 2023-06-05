import 'package:flutter/material.dart';

import '../interfaces/fk_asset.dart';

class FkAppParams extends InheritedWidget {
  final List<FkAsset> assetsSnippeds;

  const FkAppParams({
    super.key,
    required super.child,
    required this.assetsSnippeds,
  });

  @override
  bool updateShouldNotify(FkAppParams oldWidget) => false;

  static FkAppParams? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FkAppParams>();
  }
}
