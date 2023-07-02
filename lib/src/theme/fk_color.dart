import 'package:flutter/material.dart';

import 'package:flutter_kickstart/src/util/toolkit.dart';

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

  late final Color _onShade50;
  late final Color _onShade100;
  late final Color _onShade200;
  late final Color _onShade300;
  late final Color _onShade400;
  late final Color _onShade500;
  late final Color _onShade600;
  late final Color _onShade700;
  late final Color _onShade800;
  late final Color _onShade900;
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
    Color? onShade50,
    Color? onShade100,
    Color? onShade200,
    Color? onShade300,
    Color? onShade400,
    Color? onShade500,
    Color? onShade600,
    Color? onShade700,
    Color? onShade800,
    Color? onShade900,
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
    var onSList = [
      onShade50,
      onShade100,
      onShade200,
      onShade300,
      onShade400,
      onShade500,
      onShade600,
      onShade700,
      onShade800,
      onShade900
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

    for (var i = 0; i < onSList.length; i++) {
      var onSColor = onSList[i];
      if (onSColor == null) {
        var shadeColor = _getShadeColorByIndex(i);
        onSColor = Toolkit.generateHighlightHarmonicColor(shadeColor);
      }
      _setOnShadeColor(onSColor, i);
    }
    _target = target;
  }

  Color _getShadeColorByIndex(int index) {
    switch (index) {
      case 0:
        return _shade50;
      case 1:
        return _shade100;
      case 2:
        return _shade200;
      case 3:
        return _shade300;
      case 4:
        return _shade400;
      case 5:
        return _shade500;
      case 6:
        return _shade600;
      case 7:
        return _shade700;
      case 8:
        return _shade800;
      case 9:
      default:
        return _shade900;
    }
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

  void _setOnShadeColor(Color color, int index) {
    switch (index) {
      case 0:
        _onShade50 = color;
        break;
      case 1:
        _onShade100 = color;
        break;
      case 2:
        _onShade200 = color;
        break;
      case 3:
        _onShade300 = color;
        break;
      case 4:
        _onShade400 = color;
        break;
      case 5:
        _onShade500 = color;
        break;
      case 6:
        _onShade600 = color;
        break;
      case 7:
        _onShade700 = color;
        break;
      case 8:
        _onShade800 = color;
        break;
      case 9:
      default:
        _onShade900 = color;
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

  Color get onShade50 => _onShade50;
  Color get onShade100 => _onShade100;
  Color get onShade200 => _onShade200;
  Color get onShade300 => _onShade300;
  Color get onShade400 => _onShade400;
  Color get onShade500 => _onShade500;
  Color get onShade600 => _onShade600;
  Color get onShade700 => _onShade700;
  Color get onShade800 => _onShade800;
  Color get onShade900 => _onShade900;

  Color get color => _target?.call(this) ?? _shade500;
  Color get onColor {
    if (color == shade50) {
      return onShade50;
    } else if (color == shade100) {
      return onShade100;
    } else if (color == shade200) {
      return onShade200;
    } else if (color == shade300) {
      return onShade300;
    } else if (color == shade400) {
      return onShade400;
    } else if (color == shade500) {
      return onShade500;
    } else if (color == shade600) {
      return onShade600;
    } else if (color == shade700) {
      return onShade700;
    } else if (color == shade800) {
      return onShade800;
    } else {
      return onShade900;
    }
  }

  factory FkColor.color({
    required Color color,
    Color? onColor,
  }) {
    return FkColor(
      shade500: color,
      onShade500: onColor,
    );
  }

  factory FkColor.onlyShade({
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
      shade50: shade50,
      shade100: shade100,
      shade200: shade200,
      shade300: shade300,
      shade400: shade400,
      shade500: shade500,
      shade600: shade600,
      shade700: shade700,
      shade800: shade800,
      shade900: shade900,
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
    Color? onShade50,
    Color? onShade100,
    Color? onShade200,
    Color? onShade300,
    Color? onShade400,
    Color? onShade500,
    Color? onShade600,
    Color? onShade700,
    Color? onShade800,
    Color? onShade900,
  }) {
    return FkColor(
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
      onShade50: onShade50 ?? this.onShade50,
      onShade100: onShade100 ?? this.onShade100,
      onShade200: onShade200 ?? this.onShade200,
      onShade300: onShade300 ?? this.onShade300,
      onShade400: onShade400 ?? this.onShade400,
      onShade500: onShade500 ?? this.onShade500,
      onShade600: onShade600 ?? this.onShade600,
      onShade700: onShade700 ?? this.onShade700,
      onShade800: onShade800 ?? this.onShade800,
      onShade900: onShade900 ?? this.onShade900,
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
      onShade50: Color.lerp(onShade50, other.onShade50, t),
      onShade100: Color.lerp(onShade100, other.onShade100, t),
      onShade200: Color.lerp(onShade200, other.onShade200, t),
      onShade300: Color.lerp(onShade300, other.onShade300, t),
      onShade400: Color.lerp(onShade400, other.onShade400, t),
      onShade500: Color.lerp(onShade500, other.onShade500, t),
      onShade600: Color.lerp(onShade600, other.onShade600, t),
      onShade700: Color.lerp(onShade700, other.onShade700, t),
      onShade800: Color.lerp(onShade800, other.onShade800, t),
      onShade900: Color.lerp(onShade900, other.onShade900, t),
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
