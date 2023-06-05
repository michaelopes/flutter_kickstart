import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';

class FkList<T> extends ChangeNotifier with ListMixin<T> {
  late final List<T> _list;
  FkList([List<T>? list]) {
    if (list != null) {
      _list = list;
    } else {
      _list = [];
    }
  }

  @override
  int get length {
    return _list.length;
  }

  @override
  T get first {
    return _list.first;
  }

  @override
  T get last {
    return _list.last;
  }

  @override
  Iterable<T> get reversed {
    return _list.reversed;
  }

  @override
  bool get isEmpty {
    return _list.isEmpty;
  }

  @override
  bool get isNotEmpty {
    return _list.isNotEmpty;
  }

  @override
  Iterator<T> get iterator {
    return _list.iterator;
  }

  @override
  T get single {
    return _list.single;
  }

  @override
  Iterable<T> getRange(int start, int end) {
    return _list.getRange(start, end);
  }

  @override
  void replaceRange(int start, int end, Iterable<T> newContents) {
    _list.replaceRange(start, end, newContents);
    notifyListeners();
  }

  @override
  void setRange(int start, int end, Iterable<T> iterable, [int skipCount = 0]) {
    _list.setRange(start, end, iterable, skipCount);
    notifyListeners();
  }

  @override
  void fillRange(int start, int end, [T? fill]) {
    _list.fillRange(start, end, fill);
    notifyListeners();
  }

  @override
  void add(T element) {
    _list.add(element);
    notifyListeners();
  }

  @override
  void addAll(Iterable<T> iterable) {
    _list.addAll(iterable);
    notifyListeners();
  }

  @override
  bool remove(covariant T element) {
    final removed = _list.remove(element);
    if (removed) {
      notifyListeners();
    }
    return removed;
  }

  @override
  T removeAt(int index) {
    final removed = _list.removeAt(index);
    notifyListeners();
    return removed;
  }

  @override
  T removeLast() {
    final removed = _list.removeLast();
    notifyListeners();
    return removed;
  }

  @override
  void removeRange(int start, int end) {
    _list.removeRange(start, end);
    notifyListeners();
  }

  @override
  void removeWhere(bool Function(T) test) {
    _list.removeWhere(test);
    notifyListeners();
  }

  @override
  void insert(int index, T element) {
    _list.insert(index, element);
    notifyListeners();
  }

  @override
  void insertAll(int index, Iterable<T> iterable) {
    _list.insertAll(index, iterable);
    notifyListeners();
  }

  @override
  void setAll(int index, Iterable<T> iterable) {
    _list.setAll(index, iterable);
    notifyListeners();
  }

  @override
  void shuffle([Random? random]) {
    _list.shuffle(random);
    notifyListeners();
  }

  @override
  void sort([int Function(T, T)? compare]) {
    _list.sort(compare);
    notifyListeners();
  }

  @override
  List<T> sublist(int start, [int? end]) {
    return _list.sublist(start, end);
  }

  @override
  T singleWhere(bool Function(T) test, {T Function()? orElse}) {
    return _list.singleWhere(test, orElse: orElse);
  }

  @override
  Iterable<T> skip(int count) {
    return _list.skip(count);
  }

  @override
  Iterable<T> skipWhile(bool Function(T) test) {
    return _list.skipWhile(test);
  }

  @override
  void forEach(void Function(T) action) {
    _list.forEach(action);
  }

  @override
  void clear() {
    _list.clear();
    notifyListeners();
  }

  static FkList<T> of<T>(List<T> list) => FkList<T>(list);

  @override
  List<T> operator +(List<T> other) {
    final newList = _list + other;

    return newList;
  }

  @override
  T operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, T value) {
    _list[index] = value;
    notifyListeners();
  }

  @override
  set length(int value) {
    _list.length = value;
    notifyListeners();
  }
}
