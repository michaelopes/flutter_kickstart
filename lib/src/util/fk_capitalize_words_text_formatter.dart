import 'package:flutter/services.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

class FkCapitalizeWordsTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = FkToolkit.capitalizeAllWords(newValue.text);

    var spacer = "";
    var diff = newValue.selection.baseOffset - text.length;
    if (diff > 0) {
      for (var i = 0; i < diff; i++) {
        spacer = "$spacer ";
      }
    }
    return TextEditingValue(
      text: text + spacer,
      selection: newValue.selection,
    );
  }
}
