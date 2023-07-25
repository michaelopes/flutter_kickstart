import 'package:flutter/material.dart';

final class FkTypography {
  late final TextStyle _heading01;
  late final TextStyle _heading02;
  late final TextStyle _heading03;
  late final TextStyle _heading04;

  late final TextStyle _display01;
  late final TextStyle _display02;
  late final TextStyle _display03;

  late final TextStyle _headline01;
  late final TextStyle _headline02;
  late final TextStyle _headline03;
  late final TextStyle _headline04;
  late final TextStyle _headline05;
  late final TextStyle _headline06;

  late final TextStyle _bodyTiny;
  late final TextStyle _bodyMini;
  late final TextStyle _bodySmall;
  late final TextStyle _bodyDefault;
  late final TextStyle _bodyLarge;
  late final TextStyle _bodyExtra;

  late final TextStyle _buttonTiny;
  late final TextStyle _buttonMini;
  late final TextStyle _buttonSmall;
  late final TextStyle _buttonDefault;
  late final TextStyle _buttonLarge;
  late final TextStyle _buttonExtra;

  Color _bodyTextColor = Colors.black;
  Color _decorationTextColor = Colors.black;
  String? _fontFamily;

  FkTypography({
    TextStyle? heading01,
    TextStyle? heading02,
    TextStyle? heading03,
    TextStyle? heading04,
    TextStyle? display01,
    TextStyle? display02,
    TextStyle? display03,
    TextStyle? headline01,
    TextStyle? headline02,
    TextStyle? headline03,
    TextStyle? headline04,
    TextStyle? headline05,
    TextStyle? headline06,
    TextStyle? bodyTiny,
    TextStyle? bodyMini,
    TextStyle? bodySmall,
    TextStyle? bodyDefault,
    TextStyle? bodyLarge,
    TextStyle? bodyExtra,
    TextStyle? buttonTiny,
    TextStyle? buttonMini,
    TextStyle? buttonSmall,
    TextStyle? buttonDefault,
    TextStyle? buttonLarge,
    TextStyle? buttonExtra,
  }) {
    _heading01 =
        heading01 ?? const TextStyle(fontSize: 96, fontWeight: FontWeight.w900);
    _heading02 =
        heading02 ?? const TextStyle(fontSize: 88, fontWeight: FontWeight.w900);
    _heading03 =
        heading03 ?? const TextStyle(fontSize: 80, fontWeight: FontWeight.w900);
    _heading04 =
        heading04 ?? const TextStyle(fontSize: 72, fontWeight: FontWeight.w900);

    _display01 =
        display01 ?? const TextStyle(fontSize: 57, fontWeight: FontWeight.w900);
    _display02 =
        display02 ?? const TextStyle(fontSize: 45, fontWeight: FontWeight.w900);
    _display03 =
        display03 ?? const TextStyle(fontSize: 36, fontWeight: FontWeight.w900);

    _headline01 = headline01 ??
        const TextStyle(fontSize: 40, fontWeight: FontWeight.w700);
    _headline02 = headline01 ??
        const TextStyle(fontSize: 32, fontWeight: FontWeight.w700);
    _headline03 = headline01 ??
        const TextStyle(fontSize: 28, fontWeight: FontWeight.w700);
    _headline04 = headline01 ??
        const TextStyle(fontSize: 24, fontWeight: FontWeight.w700);
    _headline05 = headline01 ??
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
    _headline06 = headline01 ??
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

    _bodyTiny =
        bodyTiny ?? const TextStyle(fontSize: 10, fontWeight: FontWeight.w400);
    _bodyMini =
        bodyMini ?? const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
    _bodySmall =
        bodySmall ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
    _bodyDefault = bodyDefault ??
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
    _bodyLarge =
        bodyLarge ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
    _bodyExtra =
        bodyExtra ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

    _buttonTiny = buttonTiny ??
        const TextStyle(fontSize: 10, fontWeight: FontWeight.w600);
    _buttonMini = buttonMini ??
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    _buttonSmall = buttonSmall ??
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    _buttonDefault = buttonDefault ??
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    _buttonLarge = buttonLarge ??
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    _buttonExtra = buttonExtra ??
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  }

  void setTextExtraData({
    required Color bodyColor,
    required Color decorationColor,
    String? fontFamily,
  }) {
    _bodyTextColor = bodyColor;
    _decorationTextColor = decorationColor;
    _fontFamily = fontFamily;
  }

  TextTheme toTextTheme() {
    return TextTheme(
      headlineLarge: headline02,
      headlineMedium: headline03,
      headlineSmall: headline04,
      bodyLarge: bodyDefault,
      bodyMedium: bodySmall,
      bodySmall: bodyMini,
      displayLarge: display01,
      displayMedium: display02,
      displaySmall: display03,
      labelLarge: bodySmall.copyWith(fontWeight: FontWeight.w500),
      labelMedium: bodyMini.copyWith(fontWeight: FontWeight.w500),
      labelSmall: bodyTiny.copyWith(fontWeight: FontWeight.w500),
      titleLarge: bodyExtra,
      titleMedium: bodyDefault.copyWith(fontWeight: FontWeight.w500),
      titleSmall: bodySmall.copyWith(fontWeight: FontWeight.w500),
    ).apply(
      bodyColor: _bodyTextColor,
      decorationColor: _decorationTextColor,
      displayColor: _bodyTextColor,
      fontFamily: _fontFamily,
    );
  }

  TextStyle get heading01 => _heading01.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get heading02 => _heading02.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get heading03 => _heading03.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get heading04 => _heading04.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get display01 => _display01.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get display02 => _display02.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get display03 => _display03.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );

  TextStyle get headline01 => _headline01.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get headline02 => _headline02.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get headline03 => _headline03.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get headline04 => _headline04.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get headline05 => _headline05.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get headline06 => _headline06.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );

  TextStyle get bodyTiny => _bodyTiny.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get bodyMini => _bodyMini.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get bodySmall => _bodySmall.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get bodyDefault => _bodyDefault.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get bodyLarge => _bodyLarge.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get bodyExtra => _bodyExtra.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );

  TextStyle get buttonTiny => _buttonTiny.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get buttonMini => _buttonMini.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get buttonSmall => _buttonSmall.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get buttonDefault => _buttonDefault.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get buttonLarge => _buttonLarge.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );
  TextStyle get buttonExtra => _buttonExtra.apply(
        fontFamily: _fontFamily,
        color: _bodyTextColor,
        decorationColor: _decorationTextColor,
      );

  FkTypography copyWith({
    TextStyle? heading01,
    TextStyle? heading02,
    TextStyle? heading03,
    TextStyle? heading04,
    TextStyle? display01,
    TextStyle? display02,
    TextStyle? display03,
    TextStyle? headline01,
    TextStyle? headline02,
    TextStyle? headline03,
    TextStyle? headline04,
    TextStyle? headline05,
    TextStyle? headline06,
    TextStyle? bodyTiny,
    TextStyle? bodyMini,
    TextStyle? bodySmall,
    TextStyle? bodyDefault,
    TextStyle? bodyLarge,
    TextStyle? bodyExtra,
    TextStyle? buttonTiny,
    TextStyle? buttonMini,
    TextStyle? buttonSmall,
    TextStyle? buttonDefault,
    TextStyle? buttonLarge,
    TextStyle? buttonExtra,
  }) {
    return FkTypography(
      heading01: heading01 ?? this.heading01,
      heading02: heading02 ?? this.heading02,
      heading03: heading03 ?? this.heading03,
      heading04: heading04 ?? this.heading04,
      display01: display01 ?? this.display01,
      display02: display02 ?? this.display02,
      display03: display03 ?? this.display03,
      headline01: headline01 ?? this.headline01,
      headline02: headline02 ?? this.headline02,
      headline03: headline03 ?? this.headline03,
      headline04: headline04 ?? this.headline04,
      headline05: headline05 ?? this.headline05,
      headline06: headline06 ?? this.headline06,
      bodyTiny: bodyTiny ?? this.bodyTiny,
      bodyMini: bodyMini ?? this.bodyMini,
      bodySmall: bodySmall ?? this.bodySmall,
      bodyDefault: bodyDefault ?? this.bodyDefault,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyExtra: bodyExtra ?? this.bodyExtra,
      buttonTiny: buttonTiny ?? this.buttonTiny,
      buttonMini: buttonMini ?? this.buttonMini,
      buttonSmall: buttonSmall ?? this.buttonSmall,
      buttonDefault: buttonDefault ?? this.buttonDefault,
      buttonLarge: buttonLarge ?? this.buttonLarge,
      buttonExtra: buttonExtra ?? this.buttonExtra,
    );
  }

  FkTypography lerp(FkTypography other, double t) {
    return FkTypography(
      heading01: TextStyle.lerp(heading01, other.heading01, t),
      heading02: TextStyle.lerp(heading02, other.heading02, t),
      heading03: TextStyle.lerp(heading03, other.heading03, t),
      heading04: TextStyle.lerp(heading04, other.heading04, t),
      display01: TextStyle.lerp(display01, other.display01, t),
      display02: TextStyle.lerp(display02, other.display02, t),
      display03: TextStyle.lerp(display03, other.display03, t),
      headline01: TextStyle.lerp(headline01, other.headline01, t),
      headline02: TextStyle.lerp(headline02, other.headline02, t),
      headline03: TextStyle.lerp(headline03, other.headline03, t),
      headline04: TextStyle.lerp(headline04, other.headline04, t),
      headline05: TextStyle.lerp(headline05, other.headline05, t),
      headline06: TextStyle.lerp(headline06, other.headline06, t),
      bodyTiny: TextStyle.lerp(bodyTiny, other.bodyTiny, t),
      bodyMini: TextStyle.lerp(bodyMini, other.bodyMini, t),
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t),
      bodyDefault: TextStyle.lerp(bodyDefault, other.bodyDefault, t),
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t),
      bodyExtra: TextStyle.lerp(bodyExtra, other.bodyExtra, t),
      buttonTiny: TextStyle.lerp(buttonTiny, other.buttonTiny, t),
      buttonMini: TextStyle.lerp(buttonMini, other.buttonMini, t),
      buttonSmall: TextStyle.lerp(buttonSmall, other.buttonSmall, t),
      buttonDefault: TextStyle.lerp(buttonDefault, other.buttonDefault, t),
      buttonLarge: TextStyle.lerp(buttonLarge, other.buttonLarge, t),
      buttonExtra: TextStyle.lerp(buttonExtra, other.buttonExtra, t),
    );
  }
}
