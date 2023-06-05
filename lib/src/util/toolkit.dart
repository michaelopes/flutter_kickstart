import 'dart:async';

import 'package:flutter/material.dart';

typedef WhenCondition = bool Function();

class Toolkit {
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
}
