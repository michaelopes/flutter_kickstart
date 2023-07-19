import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_kickstart/flutter_kickstart.dart';

import '../i18n/app_localizations_delegate.dart';
import '../i18n/i18n.dart';
import '../util/global_error_observer.dart';
import 'fk_globals.dart' as globals;

typedef InjectionsFunc = List<VoidCallback> Function();
typedef FkModulesFunc = List<FkBaseModule> Function();

class FkApp extends StatefulWidget {
  const FkApp({
    super.key,
    required this.modules,
    required this.theme,
    this.appTitle = "",
    this.globalFailureHandler,
    this.injections,
  });

  final String appTitle;
  final IGlobalFailureHandler? globalFailureHandler;
  final FkModulesFunc modules;
  final InjectionsFunc? injections;
  final FkThemeData theme;

  @override
  State<FkApp> createState() => _FkAppState();
}

class _FkAppState extends State<FkApp> {
  late final RouterConfig<Object> routerConfig;
  @override
  void initState() {
    if (widget.injections != null) {
      var injections = widget.injections!.call();
      for (var inject in injections) {
        inject();
      }
    }
    final modules = widget.modules();
    routerConfig = GoRouter(
      debugLogDiagnostics: true,
      routes: modules.fold(
        <RouteBase>[],
        (previousValue, module) => previousValue..addAll(module.routes),
      ),
      refreshListenable: globals.moduleMiddleware?.reactive,
      redirect: globals.moduleMiddleware?.onViewRedirect,
      errorBuilder: globals.moduleMiddleware?.onViewError,
    );
    if (widget.globalFailureHandler != null) {
      FlutterError.onError = (error) {
        widget.globalFailureHandler?.onFailure(
          context,
          error.exception,
          error.stack ?? StackTrace.current,
        );
      };
      GlobalErrorObserver.listen = (e, s) {
        widget.globalFailureHandler?.onFailure(context, e, s);
      };
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        title: widget.appTitle,
        supportedLocales: globals.i18nDirectory.isNotEmpty
            ? I18n.I.supportedLocales
            : const <Locale>[Locale('en', 'US')],
        locale: globals.i18nDirectory.isNotEmpty ? I18n.I.defaultLocale : null,
        debugShowCheckedModeBanner: false,
        // theme: FPTheme.I.get(),
        localizationsDelegates: [
          if (globals.i18nDirectory.isNotEmpty) AppLocalizationsDelegate(),
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: widget.theme.light.nativeTheme,
        darkTheme: widget.theme.dark.nativeTheme,
        routerConfig: routerConfig,
      ),
    );
  }
}
