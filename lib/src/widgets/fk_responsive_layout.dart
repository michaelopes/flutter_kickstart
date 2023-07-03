import 'package:flutter/widgets.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

typedef FkResponsiveLayoutBuilder = Widget Function(
    BuildContext context, Size size);

class FkResponsiveLayout extends StatefulWidget {
  final FkResponsiveLayoutBuilder sm;
  final FkResponsiveLayoutBuilder md;
  final FkResponsiveLayoutBuilder lg;
  final FkResponsiveLayoutBuilder xl;

  const FkResponsiveLayout.builder({
    super.key,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  factory FkResponsiveLayout.builderByDevice({
    Key? key,
    required FkResponsiveLayoutBuilder mobile,
    required FkResponsiveLayoutBuilder tablet,
    required FkResponsiveLayoutBuilder desktop,
  }) {
    return FkResponsiveLayout.builder(
      lg: desktop,
      xl: desktop,
      md: tablet,
      sm: mobile,
    );
  }

  @override
  State<FkResponsiveLayout> createState() => _FkResponsiveLayoutState();
}

class _FkResponsiveLayoutState extends State<FkResponsiveLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var metrics = FkResponsiveMetrics.of(context);

    Widget result;
    if (metrics.isXL) {
      result = widget.xl(context, metrics.size);
    } else if (metrics.isLG) {
      result = widget.lg(context, metrics.size);
    } else if (metrics.isMD) {
      result = widget.md(context, metrics.size);
    } else {
      result = widget.sm(context, metrics.size);
    }
    return result;
  }
}
