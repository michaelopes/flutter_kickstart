export 'fk_color.dart';
export 'fk_color_palete.dart';
export 'fk_text_theme.dart';
export 'fk_theme_data.dart';

import 'package:flutter/material.dart';
import '../interfaces/fk_asset.dart';
import '../setup/fk_animations.dart';
import '../setup/fk_icons.dart';
import '../setup/fk_images.dart';
import 'fk_color.dart';
import 'fk_color_palete.dart';
import 'fk_text_theme.dart';

typedef BackgroundColorFunc = FkColor? Function(FkColorPalete colorPalete);
typedef OutlinedButtonThemeFunc = OutlinedButtonThemeData? Function(
    FkColorPalete colorPalete);
typedef ElevatedButtonThemeFunc = ElevatedButtonThemeData? Function(
    FkColorPalete colorPalete);
typedef FloatingActionButtonThemeFunc = FloatingActionButtonThemeData? Function(
    FkColorPalete colorPalete);
typedef InputDecorationThemeFunc = InputDecorationTheme? Function(
    FkColorPalete colorPalete);
typedef AppBarThemeFunc = AppBarTheme? Function(FkColorPalete colorPalete);
typedef BottomNavigationBarThemeFunc = BottomNavigationBarThemeData? Function(
    FkColorPalete colorPalete);
typedef ThemeBranchsFunc = List<FkThemeBranch>? Function(FkTheme owner);

final class FkThemeBranch {
  final String widgetName;
  final FkTheme theme;

  FkThemeBranch({
    required this.widgetName,
    required this.theme,
  });
}

final class FkTheme extends ThemeExtension<FkTheme> {
  final FkColorPalete colorPalete;
  final List<FkAssetSnippetProvider> assetsSnippets;
  final String iconsDirectory;
  final String imagesDirectory;
  final String animationsDirectory;
  late final FkColor _background;
  late final FkTypography _typography;
  late final ThemeData _themeData;
  late final List<FkThemeBranch> _themeBranchs;
  late final OutlinedButtonThemeFunc? _outlinedButtonTheme;
  late final ElevatedButtonThemeFunc? _elevatedButtonTheme;
  late final FloatingActionButtonThemeFunc? _floatingActionButtonTheme;
  late final InputDecorationThemeFunc? _inputDecorationTheme;
  late final AppBarThemeFunc? _appBarTheme;
  late final BottomNavigationBarThemeFunc? _bottomNavigationBarTheme;

  FkTypography get typography => _typography;
  FkColor get background => _background;
  ThemeData get theme => _themeData;

  dynamic get icons => FkDynamicIcons(iconsDirectory);
  dynamic get images => FkDynamicImages(imagesDirectory);
  dynamic get animations => FkDynamicAnimations(animationsDirectory);

  A assets<A extends FkAssetSnippetProvider>() {
    if (assetsSnippets.isNotEmpty) {
      var result = assetsSnippets.whereType<A>().first;
      if (result is FkIconsSnippetProvider) {
        result.setDirectory(iconsDirectory);
      } else if (result is FkAnimationsSnippetProvider) {
        result.setDirectory(animationsDirectory);
      } else if (result is FkImagesSnippetProvider) {
        result.setDirectory(imagesDirectory);
      }
      return result;
    } else {
      var message =
          "The asset snipped $A not registred on FkTheme inicialization. Register your custom asset snipped on  assetsSnippets: [] on FpApp creation";
      debugPrint(message);
      throw Exception(message);
    }
  }

  FkTheme? getBranch(String widgetName) {
    var filter = _themeBranchs.where(
      (e) => e.widgetName.trim() == widgetName.trim(),
    );
    if (filter.isNotEmpty) {
      return filter.first.theme;
    }
    return null;
  }

  FkTheme.light({
    required this.colorPalete,
    required this.iconsDirectory,
    required this.imagesDirectory,
    required this.animationsDirectory,
    this.assetsSnippets = const [],
    FkTypography? typography,
    BackgroundColorFunc? background,
    OutlinedButtonThemeFunc? outlinedButtonTheme,
    ElevatedButtonThemeFunc? elevatedButtonTheme,
    FloatingActionButtonThemeFunc? floatingActionButtonTheme,
    InputDecorationThemeFunc? inputDecorationTheme,
    AppBarThemeFunc? appBarTheme,
    BottomNavigationBarThemeFunc? bottomNavigationBarTheme,
    ThemeBranchsFunc? themeBranchs,
  }) {
    _outlinedButtonTheme = outlinedButtonTheme;
    _elevatedButtonTheme = elevatedButtonTheme;
    _floatingActionButtonTheme = floatingActionButtonTheme;
    _inputDecorationTheme = inputDecorationTheme;
    _appBarTheme = appBarTheme;
    _bottomNavigationBarTheme = bottomNavigationBarTheme;

    _themeBranchs = themeBranchs?.call(this) ?? [];
    _background = background?.call(colorPalete) ??
        FkColor.color(
          color: Colors.white,
          onColor: Colors.black,
        );
    _typography = typography ?? FkTypography();
    var oBTheme = _outlinedButtonTheme?.call(colorPalete);
    var eBTheme = _elevatedButtonTheme?.call(colorPalete);
    var fATheme = _floatingActionButtonTheme?.call(colorPalete);
    var iTheme = _inputDecorationTheme?.call(colorPalete);
    var aBTheme = _appBarTheme?.call(colorPalete);
    var bNTheme = _bottomNavigationBarTheme?.call(colorPalete);

    _typography.setMakeHighlightColor(_background.color);

    _themeData = ThemeData.light(useMaterial3: true).copyWith(
      extensions: [this],
      outlinedButtonTheme: oBTheme,
      elevatedButtonTheme: eBTheme,
      inputDecorationTheme: iTheme,
      floatingActionButtonTheme: fATheme,
      appBarTheme: aBTheme,
      bottomNavigationBarTheme: bNTheme,
      textTheme: _typography.toTextTheme(),
      colorScheme: ColorScheme.light(
        background: _background.color,
        onBackground: _background.onColor,
        primary: colorPalete.primary.color,
        primaryContainer: colorPalete.primaryVariant.color,
        onPrimary: colorPalete.primary.onColor,
        onPrimaryContainer: colorPalete.primaryVariant.onColor,
        secondary: colorPalete.secondary.color,
        secondaryContainer: colorPalete.secondary.color,
        onSecondary: colorPalete.secondary.onColor,
        onSecondaryContainer: colorPalete.secondaryVariant.onColor,
        error: colorPalete.error.color,
        errorContainer: colorPalete.errorVariant.color,
        onError: colorPalete.error.onColor,
        onErrorContainer: colorPalete.errorVariant.onColor,
      ),
    );
  }

  FkTheme.dark({
    required this.colorPalete,
    required this.iconsDirectory,
    required this.imagesDirectory,
    required this.animationsDirectory,
    this.assetsSnippets = const [],
    FkTypography? typography,
    BackgroundColorFunc? background,
    OutlinedButtonThemeFunc? outlinedButtonTheme,
    ElevatedButtonThemeFunc? elevatedButtonTheme,
    FloatingActionButtonThemeFunc? floatingActionButtonTheme,
    InputDecorationThemeFunc? inputDecorationTheme,
    AppBarThemeFunc? appBarTheme,
    BottomNavigationBarThemeFunc? bottomNavigationBarTheme,
    ThemeBranchsFunc? themeBranchs,
  }) {
    _outlinedButtonTheme = outlinedButtonTheme;
    _elevatedButtonTheme = elevatedButtonTheme;
    _floatingActionButtonTheme = floatingActionButtonTheme;
    _inputDecorationTheme = inputDecorationTheme;
    _appBarTheme = appBarTheme;
    _bottomNavigationBarTheme = bottomNavigationBarTheme;

    _themeBranchs = themeBranchs?.call(this) ?? [];
    _background = background?.call(colorPalete) ??
        FkColor.color(
          color: Colors.white,
          onColor: Colors.black,
        );
    _typography = typography ?? FkTypography();
    var oBTheme = _outlinedButtonTheme?.call(colorPalete);
    var eBTheme = _elevatedButtonTheme?.call(colorPalete);
    var fATheme = _floatingActionButtonTheme?.call(colorPalete);
    var iTheme = _inputDecorationTheme?.call(colorPalete);
    var aBTheme = _appBarTheme?.call(colorPalete);
    var bNTheme = _bottomNavigationBarTheme?.call(colorPalete);

    _typography.setMakeHighlightColor(_background.color);

    _themeData = ThemeData.dark(useMaterial3: true).copyWith(
      extensions: [this],
      outlinedButtonTheme: oBTheme,
      elevatedButtonTheme: eBTheme,
      inputDecorationTheme: iTheme,
      floatingActionButtonTheme: fATheme,
      appBarTheme: aBTheme,
      bottomNavigationBarTheme: bNTheme,
      textTheme: _typography.toTextTheme(),
      colorScheme: ColorScheme.dark(
        background: _background.color,
        onBackground: _background.onColor,
        primary: colorPalete.primary.color,
        primaryContainer: colorPalete.primaryVariant.color,
        onPrimary: colorPalete.primary.onColor,
        onPrimaryContainer: colorPalete.primaryVariant.onColor,
        secondary: colorPalete.secondary.color,
        secondaryContainer: colorPalete.secondary.color,
        onSecondary: colorPalete.secondary.onColor,
        onSecondaryContainer: colorPalete.secondaryVariant.onColor,
        error: colorPalete.error.color,
        errorContainer: colorPalete.errorVariant.color,
        onError: colorPalete.error.onColor,
        onErrorContainer: colorPalete.errorVariant.onColor,
      ),
    );
  }

  @override
  FkTheme copyWith({
    FkColorPalete? colorPalete,
    FkTypography? typography,
    BackgroundColorFunc? background,
    OutlinedButtonThemeFunc? outlinedButtonTheme,
    ElevatedButtonThemeFunc? elevatedButtonTheme,
    FloatingActionButtonThemeFunc? floatingActionButtonTheme,
    InputDecorationThemeFunc? inputDecorationTheme,
    AppBarThemeFunc? appBarTheme,
    BottomNavigationBarThemeFunc? bottomNavigationBarTheme,
  }) {
    var cPalete = colorPalete ?? this.colorPalete;
    return _themeData.brightness == Brightness.light
        ? FkTheme.light(
            colorPalete: cPalete,
            iconsDirectory: iconsDirectory,
            imagesDirectory: imagesDirectory,
            animationsDirectory: animationsDirectory,
            appBarTheme: appBarTheme ?? _appBarTheme,
            background: background ?? (_) => _background,
            bottomNavigationBarTheme:
                bottomNavigationBarTheme ?? _bottomNavigationBarTheme,
            elevatedButtonTheme: elevatedButtonTheme ?? _elevatedButtonTheme,
            floatingActionButtonTheme:
                floatingActionButtonTheme ?? _floatingActionButtonTheme,
            inputDecorationTheme: inputDecorationTheme ?? _inputDecorationTheme,
            outlinedButtonTheme: outlinedButtonTheme ?? _outlinedButtonTheme,
            themeBranchs: (_) => [],
            assetsSnippets: assetsSnippets,
            typography: typography ?? _typography,
          )
        : FkTheme.dark(
            iconsDirectory: iconsDirectory,
            imagesDirectory: imagesDirectory,
            animationsDirectory: animationsDirectory,
            colorPalete: cPalete,
            appBarTheme: appBarTheme ?? _appBarTheme,
            background: background ?? (_) => _background,
            bottomNavigationBarTheme:
                bottomNavigationBarTheme ?? _bottomNavigationBarTheme,
            elevatedButtonTheme: elevatedButtonTheme ?? _elevatedButtonTheme,
            floatingActionButtonTheme:
                floatingActionButtonTheme ?? _floatingActionButtonTheme,
            inputDecorationTheme: inputDecorationTheme ?? _inputDecorationTheme,
            outlinedButtonTheme: outlinedButtonTheme ?? _outlinedButtonTheme,
            themeBranchs: (_) => [],
            assetsSnippets: assetsSnippets,
            typography: typography ?? _typography,
          );
  }

  @override
  ThemeExtension<FkTheme> lerp(
      covariant ThemeExtension<FkTheme>? other, double t) {
    if (other is! FkTheme) {
      return this;
    }
    var cPalete = colorPalete.lerp(other.colorPalete, t);
    return _themeData.brightness == Brightness.light
        ? FkTheme.light(
            iconsDirectory: other.iconsDirectory,
            imagesDirectory: other.imagesDirectory,
            animationsDirectory: other.animationsDirectory,
            colorPalete: cPalete,
            appBarTheme: other._appBarTheme,
            background: (_) => _background.lerp(other.background, t),
            bottomNavigationBarTheme: other._bottomNavigationBarTheme,
            elevatedButtonTheme: other._elevatedButtonTheme,
            floatingActionButtonTheme: other._floatingActionButtonTheme,
            inputDecorationTheme: other._inputDecorationTheme,
            outlinedButtonTheme: other._outlinedButtonTheme,
            themeBranchs: (_) => other._themeBranchs,
            typography: typography.lerp(other._typography, t),
            assetsSnippets: other.assetsSnippets)
        : FkTheme.dark(
            iconsDirectory: other.iconsDirectory,
            imagesDirectory: other.imagesDirectory,
            animationsDirectory: other.animationsDirectory,
            colorPalete: cPalete,
            appBarTheme: other._appBarTheme,
            background: (_) => _background.lerp(other.background, t),
            bottomNavigationBarTheme: other._bottomNavigationBarTheme,
            elevatedButtonTheme: other._elevatedButtonTheme,
            floatingActionButtonTheme: other._floatingActionButtonTheme,
            inputDecorationTheme: other._inputDecorationTheme,
            outlinedButtonTheme: other._outlinedButtonTheme,
            themeBranchs: (_) => other._themeBranchs,
            typography: typography.lerp(other._typography, t),
            assetsSnippets: other.assetsSnippets,
          );
  }
}
