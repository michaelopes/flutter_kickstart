import 'package:flutter/widgets.dart';

typedef FkLayoutBuilder = Widget Function(BuildContext context, Size size);

class FkLayout extends StatefulWidget {
  final FkLayoutBuilder sm;
  final FkLayoutBuilder md;
  final FkLayoutBuilder lg;
  final FkLayoutBuilder xl;

  const FkLayout.builder({
    super.key,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  factory FkLayout.builderByDevice({
    Key? key,
    required FkLayoutBuilder mobile,
    required FkLayoutBuilder tablet,
    required FkLayoutBuilder desktop,
  }) {
    return FkLayout.builder(
      lg: desktop,
      xl: desktop,
      md: tablet,
      sm: mobile,
    );
  }

  @override
  State<FkLayout> createState() => _FkLayoutState();
}

class _FkLayoutState extends State<FkLayout> with WidgetsBindingObserver {
  final _lastSize = ValueNotifier<Size?>(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _lastSize.value = View.of(context).physicalSize;
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _lastSize.value = View.of(context).physicalSize;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _lastSize,
        builder: (_, size, ___) {
          if (size == null) {
            return const SizedBox.shrink();
          }
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
        });
  }
}
