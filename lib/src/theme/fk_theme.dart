export 'fk_color.dart';
export 'fk_color_palete.dart';
export 'fk_text_theme.dart';
export 'fk_theme_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';
import '../util/toolkit.dart';

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

typedef IconThemeFunc = IconThemeData? Function(FkColorPalete colorPalete);

// ignore: library_private_types_in_public_api
typedef ThemeBranchsFunc = List<_IFkThemeBranch>? Function(FkTheme owner);

typedef DefaultTextColorFunc = Color Function(FkColorPalete colorPalete);
typedef DefaultIndicatorColorFunc = Color Function(FkColorPalete colorPalete);

abstract interface class _IFkThemeBranch {
  String get name;
  FkTheme get theme;
}

final class FkThemeBranch implements _IFkThemeBranch {
  late final String _name;
  late final FkTheme _theme;

  FkThemeBranch({
    required String name,
    required FkTheme theme,
  }) {
    _name = name;
    _theme = theme;
  }

  @override
  String get name => _name;

  @override
  FkTheme get theme => _theme;
}

abstract base class FkCustomThemeBranch implements _IFkThemeBranch {
  final FkTheme ownerTheme;

  bool get isDark => ownerTheme.brightness == Brightness.dark;
  bool get isLight => ownerTheme.brightness == Brightness.light;

  FkCustomThemeBranch(this.ownerTheme);
}

final class FkTheme extends ThemeExtension<FkTheme> {
  final FkColorPalete colorPalete;
  final List<FkAssetSnippetProvider> assetsSnippets;
  final String iconsDirectory;
  final String imagesDirectory;
  final String animationsDirectory;
  final BoxDecoration? decoration;

  late final FkColor _background;
  late final FkTypography _typography;
  late final ThemeData _themeData;
  late final List<_IFkThemeBranch> _themeBranchs;
  late final OutlinedButtonThemeFunc? _outlinedButtonTheme;
  late final ElevatedButtonThemeFunc? _elevatedButtonTheme;
  late final FloatingActionButtonThemeFunc? _floatingActionButtonTheme;
  late final InputDecorationThemeFunc? _inputDecorationTheme;
  late final AppBarThemeFunc? _appBarTheme;
  late final BottomNavigationBarThemeFunc? _bottomNavigationBarTheme;
  late final IconThemeFunc? _iconTheme;

  late final DefaultTextColorFunc? _defaultTextColor;
  late final DefaultIndicatorColorFunc? _defaultIndicatorColor;

  FkTypography get typography => _typography;
  FkColor get background => _background;
  ThemeData get nativeTheme => _themeData;

  dynamic get icons => FkDynamicIcons(iconsDirectory);
  dynamic get images => FkDynamicImages(imagesDirectory);
  dynamic get animations => FkDynamicAnimations(animationsDirectory);

  Brightness get brightness => _themeData.brightness;

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
      (e) => e.name.trim() == widgetName.trim(),
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
    this.decoration,
    this.assetsSnippets = const [],
    FkTypography? typography,
    BackgroundColorFunc? background,
    OutlinedButtonThemeFunc? outlinedButtonTheme,
    ElevatedButtonThemeFunc? elevatedButtonTheme,
    FloatingActionButtonThemeFunc? floatingActionButtonTheme,
    InputDecorationThemeFunc? inputDecorationTheme,
    AppBarThemeFunc? appBarTheme,
    BottomNavigationBarThemeFunc? bottomNavigationBarTheme,
    IconThemeFunc? iconTheme,
    DefaultTextColorFunc? defaultTextColor,
    DefaultIndicatorColorFunc? defaultIndicatorColor,
    ThemeBranchsFunc? themeBranchs,
  }) {
    _outlinedButtonTheme = outlinedButtonTheme;
    _elevatedButtonTheme = elevatedButtonTheme;
    _floatingActionButtonTheme = floatingActionButtonTheme;
    _inputDecorationTheme = inputDecorationTheme;
    _appBarTheme = appBarTheme;
    _bottomNavigationBarTheme = bottomNavigationBarTheme;
    _iconTheme = iconTheme;

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

    if (defaultTextColor != null) {
      var textColor = defaultTextColor(colorPalete);
      _typography.setTextColor(textColor);
      _defaultTextColor = defaultTextColor;
    } else {
      var textColor = Toolkit.generateHighlightColor(_background);
      _typography.setTextColor(textColor);
      _defaultTextColor = null;
    }

    _defaultIndicatorColor = defaultIndicatorColor;

    _themeData = ThemeData.light(useMaterial3: true).copyWith(
      extensions: [this],
      outlinedButtonTheme: oBTheme,
      elevatedButtonTheme: eBTheme,
      inputDecorationTheme: iTheme,
      floatingActionButtonTheme: fATheme,
      appBarTheme: aBTheme,
      bottomNavigationBarTheme: bNTheme,
      textTheme: _typography.toTextTheme(),
      scaffoldBackgroundColor: _background,
      primaryColor: colorPalete.primary,
      iconTheme: _iconTheme?.call(colorPalete),
      indicatorColor: _defaultIndicatorColor?.call(colorPalete),
      colorScheme: ColorScheme.light(
        background: _background,
        onBackground: _background.onColor,
        primary: colorPalete.primary,
        primaryContainer: colorPalete.primaryVariant,
        onPrimary: colorPalete.primary.onColor,
        onPrimaryContainer: colorPalete.primaryVariant.onColor,
        secondary: colorPalete.secondary,
        secondaryContainer: colorPalete.secondaryVariant,
        onSecondary: colorPalete.secondary.onColor,
        onSecondaryContainer: colorPalete.secondaryVariant.onColor,
        error: colorPalete.error,
        errorContainer: colorPalete.errorVariant,
        onError: colorPalete.error.onColor,
        onErrorContainer: colorPalete.errorVariant.onColor,
      ),
    );
    _themeBranchs = themeBranchs?.call(this) ?? [];
  }

  FkTheme.dark({
    required this.colorPalete,
    required this.iconsDirectory,
    required this.imagesDirectory,
    required this.animationsDirectory,
    this.assetsSnippets = const [],
    this.decoration,
    FkTypography? typography,
    BackgroundColorFunc? background,
    OutlinedButtonThemeFunc? outlinedButtonTheme,
    ElevatedButtonThemeFunc? elevatedButtonTheme,
    FloatingActionButtonThemeFunc? floatingActionButtonTheme,
    InputDecorationThemeFunc? inputDecorationTheme,
    IconThemeFunc? iconTheme,
    AppBarThemeFunc? appBarTheme,
    BottomNavigationBarThemeFunc? bottomNavigationBarTheme,
    DefaultTextColorFunc? defaultTextColor,
    DefaultIndicatorColorFunc? defaultIndicatorColor,
    ThemeBranchsFunc? themeBranchs,
  }) {
    _outlinedButtonTheme = outlinedButtonTheme;
    _elevatedButtonTheme = elevatedButtonTheme;
    _floatingActionButtonTheme = floatingActionButtonTheme;
    _inputDecorationTheme = inputDecorationTheme;
    _appBarTheme = appBarTheme;
    _bottomNavigationBarTheme = bottomNavigationBarTheme;
    _iconTheme = iconTheme;

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

    if (defaultTextColor != null) {
      var textColor = defaultTextColor(colorPalete);
      _typography.setTextColor(textColor);
      _defaultTextColor = defaultTextColor;
    } else {
      var textColor = Toolkit.generateHighlightColor(_background);
      _typography.setTextColor(textColor);
      _defaultTextColor = null;
    }
    _defaultIndicatorColor = defaultIndicatorColor;

    _themeData = ThemeData.dark(useMaterial3: true).copyWith(
      extensions: [this],
      outlinedButtonTheme: oBTheme,
      elevatedButtonTheme: eBTheme,
      inputDecorationTheme: iTheme,
      floatingActionButtonTheme: fATheme,
      appBarTheme: aBTheme,
      bottomNavigationBarTheme: bNTheme,
      textTheme: _typography.toTextTheme(),
      iconTheme: _iconTheme?.call(colorPalete),
      primaryColor: colorPalete.primary,
      scaffoldBackgroundColor: _background,
      indicatorColor: _defaultIndicatorColor?.call(colorPalete),
      colorScheme: ColorScheme.dark(
        background: _background,
        onBackground: _background.onColor,
        primary: colorPalete.primary,
        primaryContainer: colorPalete.primaryVariant,
        onPrimary: colorPalete.primary.onColor,
        onPrimaryContainer: colorPalete.primaryVariant.onColor,
        secondary: colorPalete.secondary,
        secondaryContainer: colorPalete.secondaryVariant,
        onSecondary: colorPalete.secondary.onColor,
        onSecondaryContainer: colorPalete.secondaryVariant.onColor,
        error: colorPalete.error,
        errorContainer: colorPalete.errorVariant,
        onError: colorPalete.error.onColor,
        onErrorContainer: colorPalete.errorVariant.onColor,
      ),
    );
    _themeBranchs = themeBranchs?.call(this) ?? [];
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
    IconThemeFunc? iconTheme,
    DefaultTextColorFunc? defaultTextColor,
    DefaultIndicatorColorFunc? defaultIndicatorColor,
    BoxDecoration? decoration,
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
            iconTheme: iconTheme ?? _iconTheme,
            themeBranchs: (_) => [],
            assetsSnippets: assetsSnippets,
            typography: typography ?? _typography,
            decoration: decoration,
            defaultTextColor: defaultTextColor ?? _defaultTextColor,
            defaultIndicatorColor:
                defaultIndicatorColor ?? _defaultIndicatorColor,
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
            iconTheme: iconTheme ?? _iconTheme,
            themeBranchs: (_) => [],
            assetsSnippets: assetsSnippets,
            typography: typography ?? _typography,
            decoration: decoration,
            defaultTextColor: defaultTextColor ?? _defaultTextColor,
            defaultIndicatorColor:
                defaultIndicatorColor ?? _defaultIndicatorColor,
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
            iconTheme: other._iconTheme,
            themeBranchs: (_) => other._themeBranchs,
            typography: typography.lerp(other._typography, t),
            assetsSnippets: other.assetsSnippets,
            defaultTextColor: other._defaultTextColor,
            defaultIndicatorColor: other._defaultIndicatorColor,
            decoration: other.decoration != null
                ? decoration != null
                    ? BoxDecoration.lerp(decoration, other.decoration, t)
                    : other.decoration
                : other.decoration,
          )
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
            iconTheme: other._iconTheme,
            themeBranchs: (_) => other._themeBranchs,
            typography: typography.lerp(other._typography, t),
            assetsSnippets: other.assetsSnippets,
            defaultTextColor: other._defaultTextColor,
            decoration: other.decoration != null
                ? decoration != null
                    ? BoxDecoration.lerp(decoration, other.decoration, t)
                    : other.decoration
                : other.decoration,
          );
  }
}
