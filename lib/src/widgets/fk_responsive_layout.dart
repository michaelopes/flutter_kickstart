import 'package:flutter/widgets.dart';

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
    var size = MediaQuery.sizeOf(context);

    Widget result;
    if (size.width >= 1200) {
      result = widget.xl(context, size);
    } else if (size.width >= 992) {
      result = widget.lg(context, size);
    } else if (size.width >= 768) {
      result = widget.md(context, size);
    } else {
      result = widget.sm(context, size);
    }
    return result;
  }
}
