import 'dart:collection';
import 'package:flutter/material.dart';

class FkSet<T> extends ChangeNotifier with SetMixin<T> {
  late final Set<T> _set;
  FkSet([Set<T>? set]) {
    if (set != null) {
      _set = set;
    } else {
      _set = {};
    }
  }

  static FkSet<T> of<T>(Set<T> set) => FkSet<T>(set);

  @override
  bool add(T value) {
    final result = _set.add(value);
    if (result) {
      notifyListeners();
    }
    return result;
  }

  @override
  bool contains(Object? element) {
    return _set.contains(element);
  }

  @override
  Iterator<T> get iterator {
    return _set.iterator;
  }

  @override
  int get length {
    return _set.length;
  }

  @override
  T? lookup(Object? element) {
    return _set.lookup(element);
  }

  @override
  bool remove(Object? value) {
    final result = _set.remove(value);
    if (result) {
      notifyListeners();
    }
    return result;
  }

  @override
  Set<T> toSet() {
    return this;
  }
}
