import 'package:flutter/material.dart';

import '../../flutter_kickstart.dart';

extension ColorExt on Color {
  Color get highlightColor {
    return FkToolkit.generateHighlightColor(this);
  }

  Color get harmonicHighlightColor {
    return FkToolkit.generateHighlightHarmonicColor(this);
  }
}

extension FkColorExt on FkColor {
  Color get highlightColor {
    return FkToolkit.generateHighlightColor(this);
  }

  Color get harmonicHighlightColor {
    return FkToolkit.generateHighlightHarmonicColor(this);
  }
}
