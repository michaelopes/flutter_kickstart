import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_kickstart/src/util/fk_toolkit.dart';

abstract class FkReactive extends ChangeNotifier {
  final _store = {};

  String _initializeFocus = "";

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

      if (_initializeFocus == memberName) {
        _store[memberName] = value;
      } else if (_initializeFocus.isEmpty) {
        _store[memberName] = value;
        notifyListeners();
      }
    } else if (invocation.isGetter) {
      if (!_store.containsKey(memberName)) {
        _initializeFocus = memberName;
        init();
        if (!_store.containsKey(memberName)) {
          _store[memberName] = null;
        }
        _initializeFocus = "";
      }
      return _store[memberName];
    }
  }
}

final class EmptyReactive extends FkReactive {}
