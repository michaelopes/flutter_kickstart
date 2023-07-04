import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_kickstart/src/util/fk_toolkit.dart';

class _InternalInitializeFocus {
  final int lengthToReset;
  final String name;
  int counter = 0;
  bool setted = false;

  _InternalInitializeFocus(this.lengthToReset, this.name);

  factory _InternalInitializeFocus.empty() {
    return _InternalInitializeFocus(0, "");
  }
}

abstract class FkReactive extends ChangeNotifier {
  final _store = {};
  _InternalInitializeFocus _initializeFocus = _InternalInitializeFocus.empty();

  FkReactive() {
    init();
  }

  void merge(List<FkReactive> reactives) {
    for (var reactive in reactives) {
      reactive.addListener(notifyListeners);
    }
  }

  void init();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    final memberName = FkToolkit.getSymbolName(invocation.memberName);
    if (invocation.isSetter) {
      var value = invocation.positionalArguments.first;
      if (value is ChangeNotifier) {
        value.addListener(notifyListeners);
      }

      _initializeFocus.counter++;

      if (_initializeFocus.name == memberName) {
        _store[memberName] = value;
        _initializeFocus.setted = true;
      } else if (_initializeFocus.name.isEmpty) {
        _store[memberName] = value;
      }

      if (_initializeFocus.name.isNotEmpty &&
          _initializeFocus.counter >= _initializeFocus.lengthToReset &&
          _initializeFocus.setted) {
        _initializeFocus = _InternalInitializeFocus.empty();
      }

      notifyListeners();
    } else if (invocation.isGetter) {
      if (!_store.containsKey(memberName)) {
        _initializeFocus = _InternalInitializeFocus(_store.length, memberName);
        init();
      }
      return _store[memberName];
    }
  }
}

final class EmptyReactive extends FkReactive {}
