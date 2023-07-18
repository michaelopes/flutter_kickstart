import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/fk_reactive.dart';
import '../i18n/fk_translate_processor.dart';
import '../theme/fk_theme.dart';

final class _ViewlessHelper<T extends FkReactive> {
  late FkViewlessElement _element;
  FkTheme get theme => _element.theme;
  BuildContext get context => _element;
  GoRouter get nav => GoRouter.of(context);
  dynamic get tr => FkTranslatorProcessor(context);
}

class FkViewlessElement extends ComponentElement {
  FkViewlessElement(FkViewless super.widget) {
    _setHelperElement();
  }

  void _setHelperElement() {
    _widget._elementHelper._element = this;
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

  FkViewless get _widget => (widget as FkViewless);

  @override
  Widget build() => _widget.themeBranch.isEmpty
      ? _widget.build(this)
      : Theme(
          data: theme.nativeTheme,
          child: _widget.build(this),
        );

  @override
  void update(FkViewless newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    _setHelperElement();
    rebuild(force: true);
  }
}

abstract class _FkViewlessBase<T extends FkReactive> extends Widget {
  final T? _reactive;
  const _FkViewlessBase(this._reactive, {super.key});
}

abstract class FkViewless<T extends FkReactive> extends _FkViewlessBase<T> {
  FkViewless({super.key, T? reactive}) : super(reactive);

  final _elementHelper = _ViewlessHelper();

  T get reactive => super._reactive ?? EmptyReactive() as T;

  BuildContext get context => _elementHelper.context;
  FkTheme get theme => _elementHelper.theme;
  GoRouter get nav => _elementHelper.nav;
  dynamic get tr => _elementHelper.tr;

  @override
  FkViewlessElement createElement() => FkViewlessElement(this);

  String get themeBranch => "";

  Widget build(BuildContext context);
}
