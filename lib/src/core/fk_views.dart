import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../i18n/fk_translate_processor.dart';
import '../interfaces/fk_asset.dart';
import '../setup/fk_animations.dart';
import '../setup/fk_icons.dart';
import '../setup/fk_images.dart';
import '../widgets/fk_app_params.dart';
import 'fk_inject.dart';
import 'fk_reactive.dart';
import 'fk_viewmodel.dart';

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

  final _viewBuilderKey = GlobalKey<_SimpleViewBuilderState>();
  T get reactive => _get<T>();

  BuildContext get context => _viewBuilderKey.currentContext!;
  GoRouter get nav => GoRouter.of(context);
  dynamic get tr => FkTranslatorProcessor(context);
  dynamic get icons => FkDynamicIcons();
  dynamic get images => FkDynamicImages();
  dynamic get animations => FkDynamicAnimations();

  A assets<A extends FkAsset>() {
    var ctx = FkAppParams.of(context)!;
    if (ctx.assetsSnippeds.isNotEmpty) {
      return ctx.assetsSnippeds.whereType<A>().first;
    } else {
      var message =
          "The asset snipped $T not registred on FkApp inicialization. Register your custom asset snipped on  assetsSnippeds: [] on FpApp creation";
      debugPrint(message);
      throw Exception(message);
    }
  }

  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return _SimpleViewBuilder(
      key: _viewBuilderKey,
      builder: builder,
      reactive: reactive,
    );
  }
}

class _SimpleViewBuilder extends StatefulWidget {
  const _SimpleViewBuilder({
    super.key,
    required this.builder,
    required this.reactive,
  });

  final Widget Function(BuildContext context) builder;
  final ChangeNotifier? reactive;

  @override
  State<_SimpleViewBuilder> createState() => _SimpleViewBuilderState();
}

class _SimpleViewBuilderState extends State<_SimpleViewBuilder> {
  late final ChangeNotifier? _reactive;
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
    if (_reactive is FkReactive) {
      //  (_reactive as FkReactive).init();
    }
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return _reactive == null
        ? widget.builder(context)
        : AnimatedBuilder(
            animation: _reactive!,
            builder: (_, __) => widget.builder(context),
          );
  }
}

abstract class FkView<Vm extends FkViewModel> extends StatefulWidget
    with _FkViewWidgetLocator {
  FkView({super.key});

  BuildContext get context => _get();
  GoRouter get nav => _get();
  dynamic get tr => _get<FkTranslatorProcessor>();

  dynamic get icons => FkDynamicIcons();
  dynamic get images => FkDynamicImages();
  dynamic get animations => FkDynamicAnimations();

  T assets<T extends FkAsset>() {
    FkAppParams params = _get();
    if (params.assetsSnippeds.isNotEmpty) {
      return params.assetsSnippeds.whereType<T>().first;
    } else {
      var message =
          "The asset snipped $T not registred on FkApp inicialization. Register your custom asset snipped on  assetsSnippeds: [] on FpApp creation";
      debugPrint(message);
      throw Exception(message);
    }
  }

  Vm get vm => _get();

  Widget builder(BuildContext context);

  @override
  State<FkView> createState() => _FkViewState<Vm>();
}

class _FkViewState<Vm extends FkViewModel> extends State<FkView> {
  final _locator = FkInjectLocator();
  Vm? _viewModel;

  void _setContextParams() {
    widget._set<BuildContext>(context);
    widget._set<FkTranslatorProcessor>(FkTranslatorProcessor(context));
    widget._set<GoRouter>(GoRouter.of(context));
    widget._set<FkAppParams>(FkAppParams.of(context)!);
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
    //  _viewModel?.reactive.init();
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
    return AnimatedBuilder(
      animation: widget._get<Vm>(),
      builder: (_, __) => widget.builder(context),
    );
  }
}
