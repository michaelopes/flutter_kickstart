import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';
import 'fk_custom_page.dart';

typedef ViewBuilder<V extends FkView> = V Function(
  BuildContext context,
  GoRouterState goRouterStat,
);
typedef VmFactoryFunc<T extends FkViewModel> = T Function();

typedef RegisterFunc = Function<T extends Object>(
  T Function() factoryFunc, {
  String? instanceName,
});

typedef WrapperBuilderFunc = Widget Function(
  BuildContext,
  GoRouterState,
  Widget,
);

abstract base class FkBaseModule {
  final _routes = <RouteBase>[];
  List<RouteBase> get routes => List.unmodifiable(_routes);
}

final class FkModuleView {
  final String path;
  final ViewBuilder builder;
  final VmFactoryFunc viewModelFactory;

  final TransitionType transitionType;
  final Duration transitionDuration;
  final TransitionBuilderFunc? transitionBuilder;

  FkModuleView({
    required this.path,
    required this.builder,
    required this.viewModelFactory,
    this.transitionType = TransitionType.native,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionBuilder,
  });
}

final class FkModule extends FkBaseModule {
  final _store = <String, dynamic>{};

  void _add<T>(String key, T value) {
    _store[key] = value;
  }

  T _get<T>(String key) {
    return _store[key] as T;
  }

  void _reset() {
    _store.clear();
  }

  factory FkModule.singleView({
    required String path,
    required ViewBuilder builder,
    required VmFactoryFunc viewModelFactory,
  }) {
    return FkModule(
      views: [
        FkModuleView(
          path: path,
          builder: builder,
          viewModelFactory: viewModelFactory,
        )
      ],
    );
  }

  FkModule({
    required List<FkModuleView> views,
  }) {
    for (var i = 0; i < views.length; i++) {
      var item = views[i];
      var instanceName = FkToolkit.getInjectInstanceName(
        input: item.viewModelFactory,
      );
      FkInject.I.add(
        () {
          var vm = item.viewModelFactory();
          vm.addSetupParam("ModuleAdd", _add);
          vm.addSetupParam("ModuleGet", _get);
          if (i == 0) {
            vm.onDispose = _reset;
          }
          return vm;
        },
        instanceName: instanceName,
      );
      _routes.add(
        GoRoute(
          path: item.path,
          pageBuilder: (context, state) => FkCustomPage(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: item.builder(context, state),
            transitionType: item.transitionType,
            transitionBuilder: item.transitionBuilder,
            transitionDuration: item.transitionDuration,
          ),
        ),
      );
    }
  }
}

final class FkModuleGroup extends FkBaseModule {
  final WrapperBuilderFunc builder;
  final List<FkModule> modules;
  FkModuleGroup({
    required this.builder,
    required this.modules,
  }) {
    final navigatorKey = GlobalKey<NavigatorState>(
      debugLabel: hashCode.toString(),
    );

    var firstRoutes = modules.map((e) => e._routes.first).toList();
    var anotherRoutes = modules.fold(<RouteBase>[], (previousValue, module) {
      if (module._routes.length > 1) {
        return previousValue..addAll(module._routes.sublist(1));
      } else {
        return previousValue;
      }
    }).toList();

    _routes.add(
      ShellRoute(
        builder: builder,
        navigatorKey: navigatorKey,
        routes: firstRoutes,
      ),
    );
    _routes.addAll(anotherRoutes);
  }
}
