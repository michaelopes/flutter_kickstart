import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/fk_inject.dart';
import '../core/fk_viewmodel.dart';
import '../i18n/fk_translate_processor.dart';
import '../theme/fk_theme.dart';

final class _FkViewHelper<VM extends FkViewModel> {
  late _FkViewState _state;
  FkTheme get theme => _state.theme;
  BuildContext get context => _state.context;
  GoRouter get nav => GoRouter.of(context);
  dynamic get tr => FkTranslatorProcessor(context);
  VM get vm => _state.viewModel as VM;
}

abstract class FkView<VM extends FkViewModel> extends StatefulWidget {
  FkView({super.key});

  final _viewHelper = _FkViewHelper<VM>();

  BuildContext get context => _viewHelper.context;
  FkTheme get theme => _viewHelper.theme;
  GoRouter get nav => _viewHelper.nav;
  dynamic get tr => _viewHelper.tr;
  VM get vm => _viewHelper.vm;

  @protected
  void initView(State<FkView> state) {}
  @protected
  void disposeView(State<FkView> state) {}
  @protected
  void didUpdateView(FkView oldWidget) {}
  @protected
  void didChangeDependencies() {}
  @protected
  void deactivate() {}
  @protected
  void reassemble() {}

  String get themeBranch => "";

  Widget build(BuildContext context);

  @override
  State<FkView> createState() => _FkViewState<VM>();
}

class _FkViewState<VM extends FkViewModel> extends State<FkView> {
  final _locator = FkInjectLocator();
  VM? viewModel;

  @override
  void initState() {
    viewModel = _locator.get<VM>();
    viewModel?.addSetupParam("GetView", () => widget);
    viewModel?.init();
    viewModel?.reactive.addListener(_handleChange);
    widget._viewHelper._state = this;
    super.initState();
    widget.initView(this);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel?.reactive.removeListener(_handleChange);
    viewModel?.dispose();
    widget.disposeView(this);
  }

  @override
  void didUpdateWidget(covariant FkView oldWidget) {
    widget._viewHelper._state = this;
    super.didUpdateWidget(oldWidget);
    widget.didUpdateView(oldWidget);
    if (viewModel?.reactive != viewModel?.reactive) {
      viewModel?.reactive.removeListener(_handleChange);
      viewModel?.reactive.addListener(_handleChange);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies();
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.deactivate();
  }

  @override
  void reassemble() {
    super.reassemble();
    widget.reassemble();
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
