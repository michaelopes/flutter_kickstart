import 'package:flutter/material.dart';

import 'package:flutter_kickstart/flutter_kickstart.dart';

class FkRouter {
  final GoRouter nav;
  final GoRouterState state;
  FkRouter({
    required this.nav,
    required this.state,
  });

  factory FkRouter.of(BuildContext context) {
    return FkRouter(
      nav: GoRouter.of(context),
      state: GoRouterState.of(context),
    );
  }
}
