export 'fk_color.dart';
export 'fk_color_palete.dart';
export 'fk_typography.dart';
export 'fk_theme_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

typedef BackgroundColorFunc = FkColor? Function(
  FkColorPalete colorPalete,
);
typedef OutlinedButtonThemeFunc = OutlinedButtonThemeData? Function(
  FkColorPalete colorPalete,
  FkTypography typography,
);
typedef ElevatedButtonThemeFunc = ElevatedButtonThemeData? Function(
  FkColorPalete colorPalete,
  FkTypography typography,
);
typedef FloatingActionButtonThemeFunc = FloatingActionButtonThemeData? Function(
  FkColorPalete colorPalete,
  FkTypography typography,
);
typedef InputDecorationThemeFunc = InputDecorationTheme? Function(
  FkColorPalete colorPalete,
  FkTypography typography,
);
typedef AppBarThemeFunc = AppBarTheme? Function(
  FkColorPalete colorPalete,
  FkTypography typography,
);
typedef BottomNavigationBarThemeFunc = BottomNavigationBarThemeData? Function(
  FkColorPalete colorPalete,
  FkTypography typography,
);

typedef IconThemeFunc = IconThemeData? Function(FkColorPalete colorPalete);

typedef TextSelectionThemeFunc = TextSelectionThemeData? Function(
    FkColorPalete colorPalete);

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
  final dynamic iconsDirectory;
  final dynamic imagesDirectory;
  final dynamic animationsDirectory;
  final BoxDecoration? decoration;
  final String? fontFamily;

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
  late final TextSelectionThemeFunc? _textSelectionTheme;
  late final IconThemeFunc? _iconTheme;

  late final DefaultTextColorFunc? _defaultBodyColorTextColor;
  late final DefaultTextColorFunc? _defaultDecorationColorTextColor;
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

  OutlinedButtonThemeData? _oBTheme;
  ElevatedButtonThemeData? _eBTheme;
  FloatingActionButtonThemeData? _fATheme;
  InputDecorationTheme? _iTheme;
  AppBarTheme? _aBTheme;
  BottomNavigationBarThemeData? _bNTheme;
  TextSelectionThemeData? _tSTheme;

  OutlinedButtonThemeData? get outlinedButtonTheme => _oBTheme;
  ElevatedButtonThemeData? get elevatedButtonTheme => _eBTheme;
  FloatingActionButtonThemeData? get floatingActionButtonTheme => _fATheme;
  InputDecorationTheme? get inputDecorationTheme => _iTheme;
  AppBarTheme? get appBarTheme => _aBTheme;
  BottomNavigationBarThemeData? get bottomNavigationBarTheme => _bNTheme;
  TextSelectionThemeData? get textSelectionTheme => _tSTheme;

  FkTheme.light({
    required this.colorPalete,
    required this.iconsDirectory,
    required this.imagesDirectory,
    required this.animationsDirectory,
    this.fontFamily,
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
    DefaultTextColorFunc? defaultBodyTextColor,
    DefaultTextColorFunc? defaultDecorationColorTextColor,
    DefaultIndicatorColorFunc? defaultIndicatorColor,
    ThemeBranchsFunc? themeBranchs,
    TextSelectionThemeFunc? textSelectionTheme,
  }) {
    _outlinedButtonTheme = outlinedButtonTheme;
    _elevatedButtonTheme = elevatedButtonTheme;
    _floatingActionButtonTheme = floatingActionButtonTheme;
    _inputDecorationTheme = inputDecorationTheme;
    _appBarTheme = appBarTheme;
    _bottomNavigationBarTheme = bottomNavigationBarTheme;
    _iconTheme = iconTheme;
    _textSelectionTheme = textSelectionTheme;

    _background = background?.call(colorPalete) ??
        FkColor.color(
          color: Colors.white,
          onColor: Colors.black,
        );

    _typography = typography ?? FkTypography();
    _oBTheme = _outlinedButtonTheme?.call(colorPalete, _typography);
    _eBTheme = _elevatedButtonTheme?.call(colorPalete, _typography);
    _fATheme = _floatingActionButtonTheme?.call(colorPalete, _typography);
    _iTheme = _inputDecorationTheme?.call(colorPalete, _typography);
    _aBTheme = _appBarTheme?.call(colorPalete, _typography);
    _bNTheme = _bottomNavigationBarTheme?.call(colorPalete, _typography);
    _tSTheme = _textSelectionTheme?.call(colorPalete);

    _defaultBodyColorTextColor = defaultBodyTextColor ??
        (_) => FkToolkit.generateHighlightColor(_background);
    _defaultDecorationColorTextColor = defaultDecorationColorTextColor ??
        (_) =>
            FkToolkit.generateHighlightColor(_iTheme?.fillColor ?? _background);

    _typography.setTextExtraData(
      bodyColor: _defaultBodyColorTextColor!(colorPalete),
      decorationColor: _defaultDecorationColorTextColor!(colorPalete),
      fontFamily: fontFamily,
    );

    _defaultIndicatorColor = defaultIndicatorColor;

    _themeData = ThemeData.light(useMaterial3: true).copyWith(
      extensions: [this],
      textSelectionTheme: _tSTheme,
      outlinedButtonTheme: _oBTheme,
      elevatedButtonTheme: _eBTheme,
      inputDecorationTheme: _iTheme,
      floatingActionButtonTheme: _fATheme,
      appBarTheme: _aBTheme,
      bottomNavigationBarTheme: _bNTheme,
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
    this.fontFamily,
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
    DefaultTextColorFunc? defaultBodyTextColor,
    DefaultTextColorFunc? defaultDecorationColorTextColor,
    DefaultIndicatorColorFunc? defaultIndicatorColor,
    ThemeBranchsFunc? themeBranchs,
    TextSelectionThemeFunc? textSelectionTheme,
  }) {
    _outlinedButtonTheme = outlinedButtonTheme;
    _elevatedButtonTheme = elevatedButtonTheme;
    _floatingActionButtonTheme = floatingActionButtonTheme;
    _inputDecorationTheme = inputDecorationTheme;
    _appBarTheme = appBarTheme;
    _bottomNavigationBarTheme = bottomNavigationBarTheme;
    _iconTheme = iconTheme;
    _textSelectionTheme = textSelectionTheme;

    _background = background?.call(colorPalete) ??
        FkColor.color(
          color: Colors.white,
          onColor: Colors.black,
        );

    _typography = typography ?? FkTypography();

    _defaultBodyColorTextColor = defaultBodyTextColor ??
        (_) => FkToolkit.generateHighlightColor(_background);
    _defaultDecorationColorTextColor = defaultDecorationColorTextColor ??
        (_) =>
            FkToolkit.generateHighlightColor(_iTheme?.fillColor ?? _background);

    _typography.setTextExtraData(
      bodyColor: _defaultBodyColorTextColor!(colorPalete),
      decorationColor: _defaultDecorationColorTextColor!(colorPalete),
      fontFamily: fontFamily,
    );

    _defaultIndicatorColor = defaultIndicatorColor;

    _oBTheme = _outlinedButtonTheme?.call(colorPalete, _typography);
    _eBTheme = _elevatedButtonTheme?.call(colorPalete, _typography);
    _fATheme = _floatingActionButtonTheme?.call(colorPalete, _typography);
    _iTheme = _inputDecorationTheme?.call(colorPalete, _typography);
    _aBTheme = _appBarTheme?.call(colorPalete, _typography);
    _bNTheme = _bottomNavigationBarTheme?.call(colorPalete, _typography);
    _tSTheme = _textSelectionTheme?.call(colorPalete);

    _themeData = ThemeData.dark(useMaterial3: true).copyWith(
      extensions: [this],
      textSelectionTheme: _tSTheme,
      outlinedButtonTheme: _oBTheme,
      elevatedButtonTheme: _eBTheme,
      inputDecorationTheme: _iTheme,
      floatingActionButtonTheme: _fATheme,
      appBarTheme: _aBTheme,
      bottomNavigationBarTheme: _bNTheme,
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
  FkTheme copyWith(
      {FkColorPalete? colorPalete,
      FkTypography? typography,
      BackgroundColorFunc? background,
      OutlinedButtonThemeFunc? outlinedButtonTheme,
      ElevatedButtonThemeFunc? elevatedButtonTheme,
      FloatingActionButtonThemeFunc? floatingActionButtonTheme,
      InputDecorationThemeFunc? inputDecorationTheme,
      AppBarThemeFunc? appBarTheme,
      BottomNavigationBarThemeFunc? bottomNavigationBarTheme,
      IconThemeFunc? iconTheme,
      DefaultTextColorFunc? defaultBodyTextColor,
      DefaultTextColorFunc? defaultDecorationColorTextColor,
      DefaultIndicatorColorFunc? defaultIndicatorColor,
      BoxDecoration? decoration,
      String? fontFamily,
      TextSelectionThemeFunc? textSelectionTheme}) {
    var cPalete = colorPalete ?? this.colorPalete;
    return _themeData.brightness == Brightness.light
        ? FkTheme.light(
            fontFamily: fontFamily ?? this.fontFamily,
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
            defaultBodyTextColor:
                defaultBodyTextColor ?? _defaultBodyColorTextColor,
            defaultDecorationColorTextColor:
                defaultDecorationColorTextColor ?? _defaultBodyColorTextColor,
            defaultIndicatorColor:
                defaultIndicatorColor ?? _defaultIndicatorColor,
            textSelectionTheme: textSelectionTheme ?? _textSelectionTheme,
          )
        : FkTheme.dark(
            fontFamily: fontFamily ?? this.fontFamily,
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
            defaultBodyTextColor:
                defaultBodyTextColor ?? _defaultBodyColorTextColor,
            defaultDecorationColorTextColor:
                defaultDecorationColorTextColor ?? _defaultBodyColorTextColor,
            defaultIndicatorColor:
                defaultIndicatorColor ?? _defaultIndicatorColor,
            textSelectionTheme: textSelectionTheme ?? _textSelectionTheme,
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
            fontFamily: other.fontFamily,
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
            defaultBodyTextColor: other._defaultBodyColorTextColor,
            defaultDecorationColorTextColor: other._defaultBodyColorTextColor,
            defaultIndicatorColor: other._defaultIndicatorColor,
            textSelectionTheme: other._textSelectionTheme,
            decoration: other.decoration != null
                ? decoration != null
                    ? BoxDecoration.lerp(decoration, other.decoration, t)
                    : other.decoration
                : other.decoration,
          )
        : FkTheme.dark(
            fontFamily: other.fontFamily,
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
            defaultDecorationColorTextColor: other._defaultBodyColorTextColor,
            defaultIndicatorColor: other._defaultIndicatorColor,
            textSelectionTheme: other._textSelectionTheme,
            decoration: other.decoration != null
                ? decoration != null
                    ? BoxDecoration.lerp(decoration, other.decoration, t)
                    : other.decoration
                : other.decoration,
          );
  }
}
