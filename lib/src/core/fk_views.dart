import 'package:flutter/material.dart';

import '../../flutter_kickstart.dart';
import '../i18n/fk_translate_processor.dart';

mixin class _FkViewWidgetLocator {
  final _storage = <Type, Object>{};

  void _set<T extends Object>(T object) {
    _storage[T] = object;
  }

  T _get<T extends Object>() {
    return _storage[T]! as T;
  }

  T? _tryGet<T extends Object>() {
    return _storage[T] as T?;
  }
}

abstract class FkSimpleView<T extends FkReactive> extends Widget
    with _FkViewWidgetLocator {
  FkSimpleView({
    super.key,
    T? reactive,
  }) {
    if (reactive != null) {
      _set<T>(reactive);
    } else {
      _set<T>(EmptyReactive() as T);
    }
  }

  String get themeBranch => "";

  T get reactive => _get<T>();

  BuildContext get context => _get();
  FkTheme get theme => _get();
  GoRouter get nav => GoRouter.of(context);
  dynamic get tr => FkTranslatorProcessor(context);

  Widget builder(BuildContext context);

  void _processFkTheme(BuildContext context) {
    var fkThm = Theme.of(context).extension<FkTheme>();
    if (fkThm != null) {
      var subSkTheme = fkThm.getBranch(themeBranch);
      if (subSkTheme != null) {
        _set<FkTheme>(subSkTheme);
      } else {
        _set<FkTheme>(fkThm);
      }
    } else {
      throw Exception("FkTheme dark or light is not created on app creation!");
    }
  }

  @override
  StatelessElement createElement() => StatelessElement(
        Builder(
          builder: (context) {
            _set<BuildContext>(context);
            _processFkTheme(context);
            return themeBranch.isEmpty
                ? builder(context)
                : Theme(
                    data: _tryGet<FkTheme>()?.nativeTheme ?? Theme.of(context),
                    child: AnimatedBuilder(
                      animation: reactive,
                      builder: (_, __) => builder(context),
                    ),
                  );
          },
        ),
      );
}

abstract class FkView<Vm extends FkViewModel> extends StatefulWidget
    with _FkViewWidgetLocator {
  FkView({super.key});

  BuildContext get context => _get();
  GoRouter get nav => _get();
  dynamic get tr => _get<FkTranslatorProcessor>();
  FkTheme get theme => _get();

  String get themeBranch => "";

  Vm get vm => _get();

  Widget builder(BuildContext context);

  @override
  State<FkView> createState() => _FkViewState<Vm>();
}

class _FkViewState<Vm extends FkViewModel> extends State<FkView> {
  final _locator = FkInjectLocator();
  Vm? _viewModel;
  FkTheme? fkTheme;

  void _setContextParams() {
    widget._set<BuildContext>(context);
    widget._set<FkTranslatorProcessor>(FkTranslatorProcessor(context));
    widget._set<GoRouter>(GoRouter.of(context));

    var fkThm = Theme.of(context).extension<FkTheme>();
    if (fkThm != null) {
      var subSkTheme = fkThm.getBranch(widget.themeBranch);
      if (subSkTheme != null) {
        fkTheme = subSkTheme;
      } else {
        fkTheme = fkThm;
      }
      widget._set<FkTheme>(fkTheme!);
    } else {
      throw Exception("FkTheme dark or light is not created on app creation!");
    }

    if (_viewModel != null) {
      widget._set<Vm>(_viewModel!);
    }
  }

  @override
  void initState() {
    _viewModel = _locator.get<Vm>();
    _viewModel?.addSetupParam("GetView", () => widget);
    _viewModel?.init();
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void dispose() {
    _viewModel?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setContextParams();
    return fkTheme != null
        ? Theme(
            data: fkTheme!.nativeTheme,
            child: AnimatedBuilder(
              animation: widget._get<Vm>(),
              builder: (_, __) => widget.builder(context),
            ),
          )
        : AnimatedBuilder(
            animation: widget._get<Vm>(),
            builder: (_, __) => widget.builder(context),
          );
  }
}
