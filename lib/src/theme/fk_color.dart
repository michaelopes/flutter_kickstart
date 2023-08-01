import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

typedef FkColorTargetFunc = Color Function(FkColor thiz);

final class FkColor implements Color {
  late final Color _shade50;
  late final Color _shade100;
  late final Color _shade200;
  late final Color _shade300;
  late final Color _shade400;
  late final Color _shade500;
  late final Color _shade600;
  late final Color _shade700;
  late final Color _shade800;
  late final Color _shade900;

  late final FkColorTargetFunc? _target;

  FkColor({
    Color? shade50,
    Color? shade100,
    Color? shade200,
    Color? shade300,
    Color? shade400,
    Color? shade500,
    Color? shade600,
    Color? shade700,
    Color? shade800,
    Color? shade900,
    FkColorTargetFunc? target,
  }) {
    var sList = [
      shade50,
      shade100,
      shade200,
      shade300,
      shade400,
      shade500,
      shade600,
      shade700,
      shade800,
      shade900
    ];

    for (var i = 0; i < sList.length; i++) {
      var sColor = sList[i];
      if (sColor == null) {
        sColor = _bringColorCloser(sList, i);
        if (sColor == null) {
          if (i == 0) {
            sColor = Colors.blue[50]!;
          } else {
            sColor = Colors.blue[i * 100]!;
          }
        }
      }
      _setShadeColor(sColor, i);
    }

    _target = target;
  }

  void _setShadeColor(Color color, int index) {
    switch (index) {
      case 0:
        _shade50 = color;
        break;
      case 1:
        _shade100 = color;
        break;
      case 2:
        _shade200 = color;
        break;
      case 3:
        _shade300 = color;
        break;
      case 4:
        _shade400 = color;
        break;
      case 5:
        _shade500 = color;
        break;
      case 6:
        _shade600 = color;
        break;
      case 7:
        _shade700 = color;
        break;
      case 8:
        _shade800 = color;
        break;
      case 9:
      default:
        _shade900 = color;
        break;
    }
  }

  Color? _bringColorCloser(List<Color?> colors, int currentIndex) {
    Color? resultColor;

    var pIndex = currentIndex - 1;
    var fIndex = currentIndex + 1;
    var rule = 0;

    for (var i = 0; i < colors.length - 1; i++) {
      if (pIndex > 0 && pIndex < currentIndex && rule == 0) {
        var color = colors[pIndex];
        if (color != null) {
          resultColor = color;
          break;
        } else {
          rule = 1;
          pIndex--;
        }
      } else {
        rule = 1;
      }

      if (fIndex > currentIndex && fIndex < (colors.length - 2) && rule == 1) {
        var color = colors[fIndex];
        if (color != null) {
          resultColor = color;
          break;
        } else {
          rule = 0;
          fIndex++;
        }
      } else {
        rule = 0;
      }
    }
    return resultColor;
  }

  Color get shade50 => _shade50;
  Color get shade100 => _shade100;
  Color get shade200 => _shade200;
  Color get shade300 => _shade300;
  Color get shade400 => _shade400;
  Color get shade500 => _shade500;
  Color get shade600 => _shade600;
  Color get shade700 => _shade700;
  Color get shade800 => _shade800;
  Color get shade900 => _shade900;

  Color get color => _target?.call(this) ?? _shade500;

  factory FkColor.color({
    required Color color,
  }) {
    return FkColor(
      shade500: color,
    );
  }

  FkColor copyWith({
    Color? shade50,
    Color? shade100,
    Color? shade200,
    Color? shade300,
    Color? shade400,
    Color? shade500,
    Color? shade600,
    Color? shade700,
    Color? shade800,
    Color? shade900,
  }) {
    return FkColor(
      target: (_) => color,
      shade50: shade50 ?? this.shade50,
      shade100: shade100 ?? this.shade100,
      shade200: shade200 ?? this.shade200,
      shade300: shade300 ?? this.shade300,
      shade400: shade400 ?? this.shade400,
      shade500: shade500 ?? this.shade500,
      shade600: shade600 ?? this.shade600,
      shade700: shade700 ?? this.shade700,
      shade800: shade800 ?? this.shade800,
      shade900: shade900 ?? this.shade900,
    );
  }

  FkColor reverse({
    bool autoGenerateShade50 = true,
  }) {
    return autoGenerateShade50
        ? FkColor(
            target: (_) => color,
            shade50: shade50.highlightColor,
            shade100: shade900,
            shade200: shade800,
            shade300: shade600,
            shade400: shade700,
            shade500: shade500,
            shade600: shade400,
            shade700: shade300,
            shade800: shade200,
            shade900: shade100,
          )
        : FkColor(
            target: (_) => color,
            shade50: shade900,
            shade100: shade800,
            shade200: shade700,
            shade300: shade600,
            shade400: shade500,
            shade500: shade400,
            shade600: shade300,
            shade700: shade200,
            shade800: shade100,
            shade900: shade50,
          );
  }

  FkColor lerp(FkColor other, double t) {
    return FkColor(
      shade50: Color.lerp(shade50, other.shade50, t),
      shade100: Color.lerp(shade100, other.shade100, t),
      shade200: Color.lerp(shade200, other.shade200, t),
      shade300: Color.lerp(shade300, other.shade300, t),
      shade400: Color.lerp(shade400, other.shade400, t),
      shade500: Color.lerp(shade500, other.shade500, t),
      shade600: Color.lerp(shade600, other.shade600, t),
      shade700: Color.lerp(shade700, other.shade700, t),
      shade800: Color.lerp(shade800, other.shade800, t),
      shade900: Color.lerp(shade900, other.shade900, t),
    );
  }

  @override
  int get alpha => color.alpha;

  @override
  int get blue => color.blue;

  @override
  double computeLuminance() {
    return color.computeLuminance();
  }

  @override
  int get green => color.green;

  @override
  double get opacity => color.opacity;

  @override
  int get red => color.red;

  @override
  int get value => color.value;

  @override
  Color withAlpha(int a) {
    return color.withAlpha(a);
  }

  @override
  Color withBlue(int b) {
    return color.withBlue(b);
  }

  @override
  Color withGreen(int g) {
    return color.withBlue(g);
  }

  @override
  Color withOpacity(double opacity) {
    return color.withOpacity(opacity);
  }

  @override
  Color withRed(int r) {
    return color.withRed(r);
  }
}
