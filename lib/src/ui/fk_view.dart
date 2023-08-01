import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/fk_inject.dart';
import '../core/fk_router.dart';
import '../core/fk_viewmodel.dart';
import '../i18n/fk_translate_processor.dart';
import '../theme/fk_theme.dart';

final class _FkViewHelper<VM extends FkViewModel> {
  late _FkViewState _state;
  FkTheme get theme => _state.theme;
  BuildContext get context => _state.context;
  FkRouter get router => FkRouter.of(context);
  dynamic get tr => FkTranslatorProcessor(context);
  VM get vm => _state.viewModel as VM;
}

abstract class FkView<VM extends FkViewModel> extends StatefulWidget {
  FkView({super.key});

  final _viewHelper = _FkViewHelper<VM>();

  BuildContext get context => _viewHelper.context;
  FkTheme get theme => _viewHelper.theme;
  FkRouter get router => _viewHelper.router;
  dynamic get tr => _viewHelper.tr;
  VM get vm => _viewHelper.vm;

  SystemUiOverlayStyle? get systemOverlayStyle => null;
  String get themeBranch => "";

  Widget build(BuildContext context);

  @override
  State<FkView> createState() => _FkViewState<VM>();
}

class _FkViewState<VM extends FkViewModel> extends State<FkView> {
  final _locator = FkInjectLocator();
  VM? viewModel;
  SystemUiOverlayStyle? _systemOverlayStyleToReset;

  @override
  void initState() {
    widget._viewHelper._state = this;
    viewModel = _locator.get<VM>();
    viewModel?.addSetupParam("GetView", () => widget);
    viewModel?.init();
    viewModel?.reactive.addListener(_handleChange);

    if (widget.systemOverlayStyle != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        var fkThm = Theme.of(context).extension<FkTheme>();
        _systemOverlayStyleToReset = fkThm?.brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;
      });
      Timer(const Duration(milliseconds: 300), () {
        SystemChrome.setSystemUIOverlayStyle(widget.systemOverlayStyle!);
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    viewModel?.reactive.removeListener(_handleChange);
    viewModel?.dispose();
    if (_systemOverlayStyleToReset != null) {
      SystemChrome.setSystemUIOverlayStyle(_systemOverlayStyleToReset!);
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FkView oldWidget) {
    widget._viewHelper._state = this;
    super.didUpdateWidget(oldWidget);
    viewModel?.didUpdateView(oldWidget);
    if (viewModel?.reactive != viewModel?.reactive) {
      viewModel?.reactive.removeListener(_handleChange);
      viewModel?.reactive.addListener(_handleChange);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel?.didChangeDependencies();
  }

  @override
  void deactivate() {
    super.deactivate();
    viewModel?.deactivate();
  }

  @override
  void reassemble() {
    super.reassemble();
    viewModel?.reassemble();
  }

  void _handleChange() {
    setState(() {});
  }

  FkTheme get theme {
    var fkThm = Theme.of(context).extension<FkTheme>();
    if (fkThm != null) {
      var themeBranch = fkThm.getBranch(widget.themeBranch);
      if (themeBranch != null) {
        return themeBranch;
      } else {
        return fkThm;
      }
    } else {
      throw Exception("FkTheme dark or light is not created on app creation!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.themeBranch.isEmpty
        ? widget.build(context)
        : Theme(
            data: theme.nativeTheme,
            child: widget.build(context),
          );
  }
}
