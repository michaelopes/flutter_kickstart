import 'package:flutter/widgets.dart';

abstract class FkWidget<T extends ChangeNotifier> extends Widget {
  const FkWidget({super.key, required this.viewModel});

  final T viewModel;

  @protected
  Widget build(BuildContext context);

  @override
  FkViewElement<T> createElement() => FkViewElement<T>(this);
}

class FkViewElement<T> extends ComponentElement {
  FkViewElement(FkWidget widget) : super(widget) {
    widget.viewModel.addListener(() {
      markNeedsBuild();
    });
  }

  @override
  FkWidget get widget => super.widget as FkWidget;

  @override
  Widget build() => widget.build(this);

  @override
  void update(Widget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild(force: true);
  }
}
