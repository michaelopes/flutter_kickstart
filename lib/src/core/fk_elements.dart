import 'package:flutter/material.dart';

class FkStatefulElement extends StatefulElement {
  FkStatefulElement(
      StatefulWidget widget, this.setParams, this.setup, this.dispose)
      : super(widget);

  final void Function(BuildContext context) setParams;
  final void Function(State state)? setup;
  final void Function()? dispose;

  @override
  void mount(Element? parent, Object? newSlot) {
    setup?.call(super.state);
    super.mount(parent, newSlot);
  }

  @override
  void unmount() {
    dispose?.call();
    super.unmount();
  }

  @override
  Widget build() {
    setParams(this);
    return Theme(data: ThemeData(), child: super.build());
  }
}

class FkStatelessElement extends StatelessElement {
  FkStatelessElement(super.widget, this.setParams, this.setup, this.dispose);
  final VoidCallback? setup;
  final void Function(BuildContext context) setParams;

  final void Function()? dispose;

  @override
  void mount(Element? parent, Object? newSlot) {
    setup?.call();
    super.mount(parent, newSlot);
  }

  @override
  void unmount() {
    dispose?.call();
    super.unmount();
  }

  @override
  Widget build() {
    setParams(this);
    return Theme(data: ThemeData(), child: super.build());
  }
}
