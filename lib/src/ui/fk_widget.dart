import 'package:flutter/material.dart';
import 'package:flutter_kickstart/src/core/fk_router.dart';

import '../core/fk_reactive.dart';
import '../i18n/fk_translate_processor.dart';
import '../theme/fk_theme.dart';

final class _FkWidgetHelper {
  late FkWidgetElement _element;
  FkTheme get theme => _element.theme;
  BuildContext get context => _element;
  FkRouter get router => FkRouter.of(context);
  dynamic get tr => FkTranslatorProcessor(context);
}

class FkWidgetElement extends ComponentElement {
  FkWidgetElement(FkWidget super.widget) {
    _setHelperElement();
  }

  void _setHelperElement() {
    _widget._widgetHelper._element = this;
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _widget.reactive.addListener(_onReactiveChanged);
  }

  @override
  void unmount() {
    _widget.reactive.removeListener(_onReactiveChanged);
    super.unmount();
  }

  void _onReactiveChanged() {
    markNeedsBuild();
  }

  void _resetReactive() {
    _widget.reactive.removeListener(_onReactiveChanged);
    _widget.reactive.addListener(_onReactiveChanged);
  }

  FkTheme get theme {
    var fkThm = Theme.of(this).extension<FkTheme>();
    if (fkThm != null) {
      var themeBranch = fkThm.getBranch(_widget.themeBranch);
      if (themeBranch != null) {
        return themeBranch;
      } else {
        return fkThm;
      }
    } else {
      throw Exception("FkTheme dark or light is not created on app creation!");
    }
  }

  FkWidget get _widget => (widget as FkWidget);

  @override
  Widget build() => _widget.themeBranch.isEmpty
      ? _widget.build(this)
      : Theme(
          data: theme.nativeTheme,
          child: _widget.build(this),
        );

  @override
  void update(FkWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    _setHelperElement();
    _resetReactive();
    rebuild(force: true);
  }
}

abstract class _FkWidgetBase<T extends FkReactive> extends Widget {
  final T? _reactive;
  const _FkWidgetBase(this._reactive, {super.key});
}

abstract class FkWidget<T extends FkReactive> extends _FkWidgetBase<T> {
  FkWidget({super.key, T? reactive}) : super(reactive);

  final _widgetHelper = _FkWidgetHelper();

  T get reactive => super._reactive ?? EmptyReactive() as T;

  BuildContext get context => _widgetHelper.context;
  FkTheme get theme => _widgetHelper.theme;
  FkRouter get router => _widgetHelper.router;
  dynamic get tr => _widgetHelper.tr;

  @override
  FkWidgetElement createElement() => FkWidgetElement(this);

  String get themeBranch => "";

  Widget build(BuildContext context);
}
