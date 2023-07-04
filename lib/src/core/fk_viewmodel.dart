import 'package:flutter/material.dart';

import '../util/global_error_observer.dart';
import 'fk_inject.dart';
import 'fk_reactive.dart';

typedef ErrorListener = void Function(Object error);
typedef OnDisposeListener = void Function();

abstract class FkViewModel<R extends FkReactive> extends ChangeNotifier {
  final R reactive;
  final _setupParams = <String, dynamic>{};
  final _errors = <ErrorListener>[];
  final _loadings = <String, bool>{"default": false};
  final locator = FkInjectLocator();
  OnDisposeListener? onDispose;

  FkViewModel({
    required this.reactive,
  }) {
    reactive.addListener(notifyListeners);
  }

  void init();

  void addErrorListener(ErrorListener listener) {
    _errors.add(listener);
  }

  ///This functionality is not recommended for use on the WEB Platform.
  ///For WEB please use the parameter passing by querystring in the
  ///modules configuration.
  ///
  ///If you use this resource on the web platform, a null object error will occur.
  void addModuleValue<T>(String key, T value) {
    getSetupParam("ModuleAdd")(key, value);
  }

  ///This functionality is not recommended for use on the WEB Platform.
  ///For WEB please use the parameter passing by querystring in the
  ///modules configuration.
  ///
  ///If you use this resource on the web platform, a null object error will occur.
  T getModuleValue<T>(String key) => getSetupParam("ModuleGet")(key);

  void addSetupParam(String key, dynamic value) {
    _setupParams[key] = value;
  }

  dynamic getSetupParam(String key) {
    return _setupParams[key];
  }

  void removeSetupParam(String key) {
    _setupParams.remove(key);
  }

  void setError(Object error, StackTrace stackTrace) {
    for (var key in _loadings.keys) {
      _loadings[key] = false;
    }
    for (var error in _errors) {
      error(error);
    }
    GlobalErrorObserver.dispatch(error, stackTrace);
    notifyListeners();
  }

  void setLoading(bool status, {String key = "default"}) {
    _loadings[key] = status;
    notifyListeners();
  }

  bool loading({String key = "default"}) {
    return _loadings[key] ?? false;
  }

  @mustCallSuper
  @override
  void dispose() {
    onDispose?.call();
    super.dispose();
  }
}

abstract class FkViewModelView<R extends FkReactive, V extends Object>
    extends FkViewModel<R> {
  FkViewModelView({required super.reactive});

  V get view => getSetupParam("GetView")();
}
