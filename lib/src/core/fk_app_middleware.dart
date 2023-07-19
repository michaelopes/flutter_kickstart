import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

abstract base class FkModuleMiddleware<R extends FkReactive> {
  final R reactive;
  FkModuleMiddleware({required this.reactive});

  Widget onViewError(
    BuildContext context,
    GoRouterState state,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ERROR!!"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
        child: Text(
          state.error.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  FutureOr<String?> onViewRedirect(
    BuildContext context,
    GoRouterState state,
  );
}
