import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef WhenCondition = bool Function();

class FkToolkit {
  static String capitalizeFirst(String text) {
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }

  static String capitalizeAll(String text) {
    return text
        .trim()
        .split(" ")
        .map((e) => capitalizeFirst(e))
        .toList()
        .join(" ");
  }

  static String camelToUnderscore(String text) {
    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    String result = text
        .replaceAllMapped(exp, (Match m) => ('_${m.group(0)}'))
        .toLowerCase();
    return result;
  }

  static String formatInputedDirectory(String dir) {
    var lst = dir[dir.length - 1];
    if (lst == "/") {
      return dir.substring(0, dir.length - 1);
    }
    return dir;
  }

  static Future<void> when(
      WhenCondition condition, VoidCallback executor, int milliseconds) async {
    var limitSum = 0;
    Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      if (condition()) {
        executor();
        timer.cancel();
      } else if (limitSum > 500) {
        timer.cancel();
      }
      limitSum++;
    });
  }

  static String removeSpecialCharacters(String text) {
    final regex = RegExp(r'[^\w\s$]', unicode: true, multiLine: true);
    return text.replaceAll(regex, '');
  }

  static String getSymbolName(Symbol symbol) {
    return removeSpecialCharacters(symbol.toString().replaceAll("Symbol", ""));
  }

  static String getInjectInstanceName<T extends Object>({T? input}) {
    if (input is Function) {
      return input.runtimeType.toString().replaceAll("() => ", "");
    }

    return T.toString();
  }

  static Color generateHighlightColor(Color tColor) {
    if (ThemeData.estimateBrightnessForColor(tColor) == Brightness.dark) {
      return const Color(0xFFF6F6F8);
    }
    return const Color(0xFF1A191B);
  }

  static Color generateHighlightHarmonicColor(Color tColor) {
    var hslColor = HSLColor.fromColor(tColor);

    double adjustedSaturation = hslColor.saturation - 0.2;

    double adjustedLightness = hslColor.lightness > 0.5
        ? hslColor.lightness - 0.2
        : hslColor.lightness + 0.2;

    if (adjustedLightness > 1) {
      adjustedLightness = 1;
    } else if (adjustedLightness < 0) {
      adjustedLightness = 0;
    }

    if (adjustedSaturation > 1) {
      adjustedSaturation = 1;
    } else if (adjustedSaturation < 0) {
      adjustedSaturation = 0;
    }

    var highlightHslColor = HSLColor.fromAHSL(
        1, hslColor.hue, adjustedSaturation, adjustedLightness);

    return highlightHslColor.toColor();
  }

  static String formatBrDatetime(DateTime date) {
    var format = DateFormat("dd/MM/yyyy HH:mm", "pt_BR");
    return format.format(date);
  }

  static String formatMoney(DateTime date) {
    final formatedPrice = NumberFormat("#,##0.00", "pt_BR");
    return formatedPrice.format(formatedPrice);
  }

  static String brDatetime2IsoDatetime(
    String brDate, {
    String? timePreposition,
  }) {
    var split1 = brDate.split(" ");
    String date = "";
    String time = "";
    if (split1.length > 1) {
      date = split1[0];
      time = (timePreposition ?? " ") + split1[1].substring(0, 5);
    } else {
      date = brDate;
    }
    var split2 = date.split("/");
    if (split2.length == 3) {
      var result = "${split2[2]}-${split2[1]}-${split2[0]}$time";
      return result;
    } else {
      return "";
    }
  }

  static String capitalizeFirstWord(String str) {
    return "${str[0].toUpperCase()}${str.substring(1).toLowerCase()}";
  }

  static String capitalizeAllWords(String text) {
    return text
        .trim()
        .split(" ")
        .map((e) => capitalizeFirstWord(e))
        .toList()
        .join(" ");
  }

  static String getNameInitials(String name) {
    List<String> words = name.split(" ");
    if (words.length > 1) {
      String first = words[0];
      String last = words[words.length - 1];
      return "${first[0]}${last[0]}".toUpperCase();
    } else {
      return name.substring(0, 2).toUpperCase();
    }
  }

  static String longName2ShortName(String name, {bool withCrop = false}) {
    var splited = name.trim().replaceAll("  ", "").split(" ");
    return splited.length > 1
        ? withCrop
            ? stringCrop("${splited.first} ${splited.last}", 15)
            : "${splited.first} ${splited.last}"
        : name;
  }

  static String stringCrop(String str, int length) {
    if (str.length > length) {
      return "${str.substring(0, length)}...";
    } else {
      return str;
    }
  }

  static String fileSizeFormat(dynamic size, [int round = 2]) {
    var divider = 1024;
    int size0;
    try {
      size0 = int.parse(size.toString());
    } catch (e) {
      throw ArgumentError('Can not parse the size parameter: $e');
    }

    if (size0 < divider) {
      return '${size0}B';
    }

    if (size0 < divider * divider && size0 % divider == 0) {
      return '${(size0 / divider).toStringAsFixed(0)}KB';
    }

    if (size0 < divider * divider) {
      return '${(size0 / divider).toStringAsFixed(round)}KB';
    }

    if (size0 < divider * divider * divider && size0 % divider == 0) {
      return '${(size0 / (divider * divider)).toStringAsFixed(0)}MB';
    }

    if (size0 < divider * divider * divider) {
      return '${(size0 / divider / divider).toStringAsFixed(round)}MB';
    }

    if (size0 < divider * divider * divider * divider && size0 % divider == 0) {
      return '${(size0 / (divider * divider * divider)).toStringAsFixed(0)}GB';
    }

    if (size0 < divider * divider * divider * divider) {
      return '${(size0 / divider / divider / divider).toStringAsFixed(round)}GB';
    }

    if (size0 < divider * divider * divider * divider * divider &&
        size0 % divider == 0) {
      num r = size0 / divider / divider / divider / divider;
      return '${r.toStringAsFixed(0)}TB';
    }

    if (size0 < divider * divider * divider * divider * divider) {
      num r = size0 / divider / divider / divider / divider;
      return '${r.toStringAsFixed(round)}TB';
    }

    if (size0 < divider * divider * divider * divider * divider * divider &&
        size0 % divider == 0) {
      num r = size0 / divider / divider / divider / divider / divider;
      return '${r.toStringAsFixed(0)}PB';
    } else {
      num r = size0 / divider / divider / divider / divider / divider;
      return '${r.toStringAsFixed(round)}PB';
    }
  }

  static int doubleHourToMilliseconds(double hour) {
    var a = hour * 60;
    return (a * 60000).toInt();
  }

  static double millisecondsToDoubleHour(int milliseconds) {
    var a = milliseconds / 60000;
    return a / 60;
  }

  static double dynamicToDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.parse(value);
    }
    return value;
  }

  static double? dynamicToDoubleNullable(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.parse(value);
    }
    return value;
  }
}
