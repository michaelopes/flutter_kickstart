import 'package:flutter/material.dart';

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

class FkResposiveRow extends StatefulWidget {
  const FkResposiveRow({super.key, required this.children});
  final List<FkResponsiveCol> children;

  @override
  State<FkResposiveRow> createState() => _FkResposiveRowState();
}

class _FkResposiveRowState extends State<FkResposiveRow> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Wrap(
        children: widget.children
            .map((e) => e._calculatedWidget(constraints.maxWidth))
            .toList(),
      );
    });
  }
}

class FkResponsiveCol {
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

  Widget _calculatedWidget(double parentWidth) {
    var colWidth = parentWidth / 12;
    var colNumber = _getColsNumber(parentWidth);
    var maxWidth = colWidth * colNumber;
    return colNumber == 0
        ? const SizedBox.shrink()
        : AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: colWidth * colNumber,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: child,
            ),
          );
  }

  int _getColsNumber(double parentWidth) {
    if (all != null) {
      return all!.index;
    }
    int result;
    if (parentWidth >= 1200) {
      result = xl.index;
    } else if (parentWidth >= 992) {
      result = lg.index;
    } else if (parentWidth >= 768) {
      result = md.index;
    } else {
      result = sm.index;
    }
    return result;
  }
}
