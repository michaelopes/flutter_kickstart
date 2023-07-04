typedef FactoryFunc<T> = T Function();

final class _FkInjectItem<T> {
  final FactoryFunc<T> factoryFunc;
  final bool isSingleton;
  final String? instanceName;
  T? _singletonInstance;

  _FkInjectItem({
    required this.factoryFunc,
    required this.isSingleton,
    required this.instanceName,
  });

  String get restoreId => instanceName ?? T.toString();

  T get instance {
    if (isSingleton) {
      _singletonInstance ??= factoryFunc();
      return _singletonInstance!;
    } else {
      return factoryFunc();
    }
  }
}

final class FkInject {
  FkInject._internal();
  final _store = <_FkInjectItem>[];
  static final FkInject I = FkInject._internal();

  void add<T extends Object>(T Function() factoryFunc, {String? instanceName}) {
    _store.add(
      _FkInjectItem<T>(
        factoryFunc: factoryFunc,
        instanceName: instanceName,
        isSingleton: false,
      ),
    );
  }

  void addSingleton<T extends Object>(T Function() factoryFunc,
      {String? instanceName}) {
    _store.add(
      _FkInjectItem<T>(
        factoryFunc: factoryFunc,
        instanceName: instanceName,
        isSingleton: true,
      ),
    );
  }
}

final class FkInjectLocator {
  bool isRegistered<T extends Object>({
    String? instanceName,
  }) =>
      FkInject.I._store
          .where(
            (e) => e.restoreId == T.toString() || e.restoreId == instanceName,
          )
          .isNotEmpty;

  T get<T extends Object>({String? instanceName}) {
    if (!isRegistered<T>(
      instanceName: instanceName,
    )) {
      throw ("The object ${instanceName ?? T} is not registred");
    }
    return FkInject.I._store
        .firstWhere(
          (e) => e.restoreId == T.toString() || e.restoreId == instanceName,
        )
        .instance;
  }
}
