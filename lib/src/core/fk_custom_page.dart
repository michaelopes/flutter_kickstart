import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enums/transition_type.dart';

typedef TransitionBuilderFunc = Widget Function(
    BuildContext, Animation<double>, Animation<double>, Widget);

class FkCustomPage<T> extends Page<T> {
  const FkCustomPage({
    super.key,
    super.restorationId,
    required this.transitionType,
    required this.child,
    this.maintainState = true,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionBuilder,
  });

  final TransitionType transitionType;
  final Widget child;
  final bool maintainState;
  final Duration transitionDuration;
  final TransitionBuilderFunc? transitionBuilder;

  @override
  Route<T> createRoute(BuildContext context) => _buildRoute();

  Route<T> _buildRoute() {
    bool isNativeTransition = (transitionType == TransitionType.native ||
        transitionType == TransitionType.nativeModal);

    if (isNativeTransition) {
      return MaterialPageRoute<T>(
        settings: this,
        fullscreenDialog: transitionType == TransitionType.nativeModal,
        maintainState: maintainState,
        builder: (BuildContext context) {
          return child;
        },
      );
    } else if (transitionType == TransitionType.material ||
        transitionType == TransitionType.materialFullScreenDialog) {
      return MaterialPageRoute<T>(
        settings: this,
        fullscreenDialog:
            transitionType == TransitionType.materialFullScreenDialog,
        maintainState: maintainState,
        builder: (BuildContext context) {
          return child;
        },
      );
    } else if (transitionType == TransitionType.cupertino ||
        transitionType == TransitionType.cupertinoFullScreenDialog) {
      return CupertinoPageRoute<T>(
        settings: this,
        fullscreenDialog:
            transitionType == TransitionType.cupertinoFullScreenDialog,
        maintainState: maintainState,
        builder: (BuildContext context) {
          return child;
        },
      );
    } else {
      RouteTransitionsBuilder? routeTransitionsBuilder;

      if (transitionType == TransitionType.custom &&
          transitionBuilder != null) {
        routeTransitionsBuilder = transitionBuilder;
      } else {
        routeTransitionsBuilder = _transitionsBuilder(transitionType);
      }

      return PageRouteBuilder<T>(
        opaque: true,
        settings: this,
        maintainState: maintainState,
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return child;
        },
        transitionDuration: transitionType == TransitionType.none
            ? Duration.zero
            : transitionDuration,
        reverseTransitionDuration: transitionType == TransitionType.none
            ? Duration.zero
            : transitionDuration,
        transitionsBuilder: transitionType == TransitionType.none
            ? (_, __, ___, child) => child
            : routeTransitionsBuilder!,
      );
    }
  }
}

RouteTransitionsBuilder _transitionsBuilder(TransitionType? transitionType) {
  return (
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (transitionType == TransitionType.fadeIn) {
      return FadeTransition(opacity: animation, child: child);
    } else {
      const topLeft = Offset(0.0, 0.0);
      const topRight = Offset(1.0, 0.0);
      const bottomLeft = Offset(0.0, 1.0);

      var startOffset = bottomLeft;
      var endOffset = topLeft;

      if (transitionType == TransitionType.inFromLeft) {
        startOffset = const Offset(-1.0, 0.0);
        endOffset = topLeft;
      } else if (transitionType == TransitionType.inFromRight) {
        startOffset = topRight;
        endOffset = topLeft;
      } else if (transitionType == TransitionType.inFromBottom) {
        startOffset = bottomLeft;
        endOffset = topLeft;
      } else if (transitionType == TransitionType.inFromTop) {
        startOffset = const Offset(0.0, -1.0);
        endOffset = topLeft;
      }

      return SlideTransition(
        key: UniqueKey(),
        position: Tween<Offset>(
          begin: startOffset,
          end: endOffset,
        ).animate(animation),
        child: child,
      );
    }
  };
}
