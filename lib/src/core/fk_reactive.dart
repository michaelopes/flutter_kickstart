import 'package:flutter/foundation.dart';
import 'package:flutter_kickstart/src/util/toolkit.dart';

abstract class FkReactive extends ChangeNotifier {
  final _store = {};

  void merge(List<FkReactive> reactives) {
    for (var reactive in reactives) {
      reactive.addListener(notifyListeners);
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    final memberName = Toolkit.getSymbolName(invocation.memberName);
    if (invocation.isSetter) {
      var value = invocation.positionalArguments.first;
      if (value is ChangeNotifier) {
        value.addListener(notifyListeners);
      }
      _store[memberName] = value;
      notifyListeners();
    } else if (invocation.isGetter) {
      return _store[memberName];
    }
  }
}

final class EmptyReactive extends FkReactive {}
