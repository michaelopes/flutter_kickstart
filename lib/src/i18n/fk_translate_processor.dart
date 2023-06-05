import 'package:flutter/material.dart';
import 'package:flutter_kickstart/src/i18n/app_translate.dart';

class FkTranslatorProcessor {
  final BuildContext context;
  final String strTracker;

  FkTranslatorProcessor(this.context, {this.strTracker = ""});

  @override
  dynamic noSuchMethod(Invocation invocation) {
    var fileName = invocation.memberName
        .toString()
        .replaceAll("Symbol(\"", "")
        .replaceAll("\")", "");

    var tr = strTracker.isEmpty ? fileName : "$strTracker.$fileName";
    if (invocation.isMethod) {
      return AppTranslate.tr(tr, context);
    } else {
      return FkTranslatorProcessor(
        context,
        strTracker: tr,
      );
    }
  }
}
