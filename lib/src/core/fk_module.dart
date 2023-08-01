import 'package:flutter/material.dart';

import 'package:flutter_kickstart/flutter_kickstart.dart';

import 'fk_custom_page.dart';
import 'fk_route.dart';

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

class FkModuleViewList {
  static final List<({String path, bool loggedArea})> _nodes = [];

  static void _add(({String path, bool loggedArea}) node) {
    _nodes.add(node);
  }

  static List<(String path, bool loggedArea)> get nodes {
    return List.unmodifiable(_nodes);
  }

  static bool checkIsLoggedArea(String path) {
    var res = _nodes.where((e) => e.path == path);
    if (res.isEmpty) {
      return false;
    } else {
      return res.first.loggedArea;
    }
  }
}

final class FkModuleView {
  final String path;
  final ViewBuilder builder;
  final VmFactoryFunc viewModelFactory;
  final bool loggedArea;
  final GlobalKey<NavigatorState>? parentNavigadorKey;

  final TransitionType transitionType;
  final Duration transitionDuration;
  final TransitionBuilderFunc? transitionBuilder;

  FkModuleView({
    required this.path,
    required this.builder,
    required this.viewModelFactory,
    this.loggedArea = true,
    this.parentNavigadorKey,
    this.transitionType = TransitionType.native,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionBuilder,
  }) {
    FkModuleViewList._add((path: path, loggedArea: loggedArea));
  }
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
    final GlobalKey<NavigatorState>? parentNavigadorKey,
    final bool loggedArea = true,
    final TransitionType transitionType = TransitionType.native,
    final Duration transitionDuration = const Duration(milliseconds: 300),
    final TransitionBuilderFunc? transitionBuilder,
  }) {
    return FkModule(
      views: [
        FkModuleView(
          path: path,
          builder: builder,
          loggedArea: loggedArea,
          viewModelFactory: viewModelFactory,
          parentNavigadorKey: parentNavigadorKey,
          transitionBuilder: transitionBuilder,
          transitionDuration: transitionDuration,
          transitionType: transitionType,
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
      var path = item.path;
      _routes.add(
        FkRoute(
          path: path,
          name: path,
          parentNavigatorKey: item.parentNavigadorKey,
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
  final GlobalKey<NavigatorState>? navigatorKey;
  FkModuleGroup({
    required this.builder,
    required this.modules,
    this.navigatorKey,
  }) {
    final navKey = navigatorKey ??
        GlobalKey<NavigatorState>(
          debugLabel: hashCode.toString(),
        );

    var firstRoutes = modules
        .map(
          (e) => (e._routes.first is FkRoute)
              ? (e._routes.first as FkRoute)
                  .copyWith(parentNavigatorKey: navKey)
              : e._routes.first,
        )
        .toList();
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
        navigatorKey: navKey,
        routes: firstRoutes,
      ),
    );
    _routes.addAll(anotherRoutes);
  }
}

final class FkModuleStatedGroup extends FkBaseModule {
  final WrapperBuilderFunc builder;
  final List<FkModule> modules;

  FkModuleStatedGroup({
    required this.builder,
    required this.modules,
  }) {
    var firstRoutes = modules.map((e) => e._routes.first).toList();
    var anotherRoutes = modules.fold(<RouteBase>[], (previousValue, module) {
      if (module._routes.length > 1) {
        return previousValue..addAll(module._routes.sublist(1));
      } else {
        return previousValue;
      }
    }).toList();

    var staked = StatefulShellRoute.indexedStack(
      builder: builder,
      branches: firstRoutes
          .map(
            (e) => StatefulShellBranch(
              navigatorKey: GlobalKey<NavigatorState>(
                debugLabel: e.toString(),
              ),
              routes: [e],
            ),
          )
          .toList(),
    );
    _routes.add(
      staked,
    );
    _routes.addAll(anotherRoutes);
  }
}
