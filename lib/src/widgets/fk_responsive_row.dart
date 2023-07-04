import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

enum FkResponsiveSize {
  none,
  col1,
  col2,
  col3,
  col4,
  col5,
  col6,
  col7,
  col8,
  col9,
  col10,
  col11,
  col12,
}

class FkResponsiveRow extends StatefulWidget {
  const FkResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
  });

  final List<FkResponsiveCol> children;
  final FkResponsiveSpacing? mainAxisSpacing;
  final FkResponsiveSpacing? crossAxisSpacing;

  @override
  State<FkResponsiveRow> createState() => _FkResponsiveRowState();
}

class _FkResponsiveRowState extends State<FkResponsiveRow> {
  late final _mainAxisSpacing =
      (widget.mainAxisSpacing ?? FkResponsiveSpacing());
  late final _crossAxisSpacing =
      (widget.crossAxisSpacing ?? FkResponsiveSpacing());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Wrap(
        children: widget.children.map((e) {
          var isLast = widget.children.last == e;
          return e._calculatedWidget(
            parentWidth: constraints.maxWidth,
            crossAxisSpacing: _crossAxisSpacing,
            mainAxisSpacing: _mainAxisSpacing,
            isLast: isLast,
          );
        }).toList(),
      );
    });
  }
}

final class FkResponsiveSpacing {
  final double sm;
  final double md;
  final double lg;
  final double xl;

  FkResponsiveSpacing({
    this.sm = 0,
    this.md = 0,
    this.lg = 0,
    this.xl = 0,
  });
}

final class FkResponsiveCol {
  final FkResponsiveSize sm;
  final FkResponsiveSize md;
  final FkResponsiveSize lg;
  final FkResponsiveSize xl;
  final FkResponsiveSize? all;

  final Widget child;

  FkResponsiveCol({
    this.sm = FkResponsiveSize.col12,
    this.md = FkResponsiveSize.col12,
    this.lg = FkResponsiveSize.col12,
    this.xl = FkResponsiveSize.col12,
    this.all,
    required this.child,
  });

  Widget _calculatedWidget({
    required double parentWidth,
    required FkResponsiveSpacing mainAxisSpacing,
    required FkResponsiveSpacing crossAxisSpacing,
    required bool isLast,
  }) {
    var mainASpacing = _getSpacing(parentWidth, mainAxisSpacing);
    var crossASpacing = _getSpacing(parentWidth, crossAxisSpacing);
    var colWidth = parentWidth / 12;
    var colNumber = _getColsNumber(parentWidth);
    var maxWidth = (colWidth * colNumber);
    return colNumber == 0
        ? const SizedBox.shrink()
        : AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: colWidth * colNumber,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  right: isLast ? 0 : mainASpacing,
                  bottom: isLast ? 0 : crossASpacing,
                ),
                child: child,
              ),
            ),
          );
  }

  double _getSpacing(double parentWidth, FkResponsiveSpacing spacing) {
    var metrics = FkResponsiveMetrics.fromSize(Size(parentWidth, 0));
    double result;
    if (metrics.isXL) {
      result = spacing.xl;
    } else if (metrics.isLG) {
      result = spacing.lg;
    } else if (metrics.isMD) {
      result = spacing.md;
    } else {
      result = spacing.sm;
    }
    return result;
  }

  int _getColsNumber(double parentWidth) {
    if (all != null) {
      return all!.index;
    }
    var metrics = FkResponsiveMetrics.fromSize(Size(parentWidth, 0));
    int result;
    if (metrics.isXL) {
      result = xl.index;
    } else if (metrics.isLG) {
      result = lg.index;
    } else if (metrics.isMD) {
      result = md.index;
    } else {
      result = sm.index;
    }
    return result;
  }
}
