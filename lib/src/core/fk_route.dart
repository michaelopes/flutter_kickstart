import 'package:flutter/material.dart';

import '../../flutter_kickstart.dart';

class FkRoute extends GoRoute {
  FkRoute({
    required super.path,
    super.name,
    super.builder,
    super.pageBuilder,
    super.parentNavigatorKey,
    super.redirect,
    super.routes = const <RouteBase>[],
  });

  FkRoute copyWith({GlobalKey<NavigatorState>? parentNavigatorKey}) {
    return FkRoute(
      path: path,
      builder: builder,
      name: name,
      pageBuilder: pageBuilder,
      parentNavigatorKey: parentNavigatorKey ?? this.parentNavigatorKey,
      redirect: redirect,
      routes: routes,
    );
  }
}
