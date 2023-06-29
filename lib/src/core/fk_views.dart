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
}

abstract class FkSimpleView<T extends FkReactive> extends StatelessWidget
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

  final _viewBuilderKey = GlobalKey<_SimpleViewBuilderState>();
  T get reactive => _get<T>();

  BuildContext get context => _viewBuilderKey.currentContext!;
  FkTheme get theme => _viewBuilderKey.currentState!.fkTheme!;
  GoRouter get nav => GoRouter.of(context);
  dynamic get tr => FkTranslatorProcessor(context);

  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return _SimpleViewBuilder(
      key: _viewBuilderKey,
      builder: builder,
      reactive: reactive,
      themeBranch: themeBranch,
    );
  }
}

class _SimpleViewBuilder extends StatefulWidget {
  const _SimpleViewBuilder({
    super.key,
    required this.builder,
    required this.reactive,
    required this.themeBranch,
  });

  final Widget Function(BuildContext context) builder;
  final ChangeNotifier? reactive;
  final String themeBranch;

  @override
  State<_SimpleViewBuilder> createState() => _SimpleViewBuilderState();
}

class _SimpleViewBuilderState extends State<_SimpleViewBuilder> {
  late final ChangeNotifier? _reactive;

  FkTheme? fkTheme;

  @override
  void initState() {
    _reactive = widget.reactive;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  void _processFkTheme() {
    var fkThm = Theme.of(context).extension<FkTheme>();
    if (fkThm != null) {
      var subSkTheme = fkThm.getBranch(widget.themeBranch);
      if (subSkTheme != null) {
        fkTheme = subSkTheme;
      } else {
        fkTheme = fkThm;
      }
    } else {
      throw Exception("FkTheme dark or light is not created on app creation!");
    }
  }

  @override
  Widget build(BuildContext context) {
    _processFkTheme();
    return Theme(
      data: fkTheme?.theme ?? Theme.of(context),
      child: _reactive == null
          ? widget.builder(context)
          : AnimatedBuilder(
              animation: _reactive!,
              builder: (_, __) => widget.builder(context),
            ),
    );
  }
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
            data: fkTheme!.theme,
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
