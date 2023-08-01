import 'fk_color.dart';

final class FkColorPalete {
  late final FkColor _primary;
  late final FkColor _primaryVariant;

  late final FkColor _secondary;
  late final FkColor _secondaryVariant;

  late final FkColor _neutral;
  late final FkColor _neutralVariant;

  late final FkColor _error;
  late final FkColor _errorVariant;

  FkColorPalete({
    FkColor? primary,
    FkColor? primaryVariant,
    FkColor? secondary,
    FkColor? secondaryVariant,
    FkColor? neutral,
    FkColor? neutralVariant,
    FkColor? error,
    FkColor? errorVariant,
  }) {
    _primary = primary ?? FkColor();
    _primaryVariant = primaryVariant ?? FkColor();
    _secondary = secondary ?? FkColor();
    _secondaryVariant = secondaryVariant ?? FkColor();
    _neutral = neutral ?? FkColor();
    _neutralVariant = neutralVariant ?? FkColor();
    _error = error ?? FkColor();
    _errorVariant = errorVariant ?? FkColor();
  }

  FkColor get primary => _primary;
  FkColor get primaryVariant => _primaryVariant;
  FkColor get secondary => _secondary;
  FkColor get secondaryVariant => _secondaryVariant;
  FkColor get neutral => _neutral;
  FkColor get neutralVariant => _neutralVariant;
  FkColor get error => _error;
  FkColor get errorVariant => _errorVariant;

  FkColorPalete copyWith({
    FkColor? primary,
    FkColor? primaryVariant,
    FkColor? secondary,
    FkColor? secondaryVariant,
    FkColor? neutral,
    FkColor? neutralVariant,
    FkColor? error,
    FkColor? errorVariant,
  }) {
    return FkColorPalete(
      primary: primary ?? this.primary,
      primaryVariant: primaryVariant ?? this.primaryVariant,
      secondary: secondary ?? this.secondary,
      secondaryVariant: secondaryVariant ?? this.secondaryVariant,
      neutral: neutral ?? this.neutral,
      neutralVariant: neutralVariant ?? this.neutralVariant,
      error: error ?? this.error,
      errorVariant: errorVariant ?? this.errorVariant,
    );
  }

  FkColorPalete reverseAll({
    bool autoGenerateShade50 = true,
  }) {
    return FkColorPalete(
      primary: primary.reverse(
        autoGenerateShade50: autoGenerateShade50,
      ),
      primaryVariant: primaryVariant.reverse(
        autoGenerateShade50: autoGenerateShade50,
      ),
      secondary: secondary.reverse(
        autoGenerateShade50: autoGenerateShade50,
      ),
      secondaryVariant: secondaryVariant.reverse(
        autoGenerateShade50: autoGenerateShade50,
      ),
      neutral: neutral.reverse(
        autoGenerateShade50: autoGenerateShade50,
      ),
      neutralVariant: neutralVariant.reverse(
        autoGenerateShade50: autoGenerateShade50,
      ),
      error: error.reverse(
        autoGenerateShade50: autoGenerateShade50,
      ),
      errorVariant: errorVariant.reverse(
        autoGenerateShade50: autoGenerateShade50,
      ),
    );
  }

  FkColorPalete lerp(FkColorPalete other, double t) {
    return FkColorPalete(
      primary: primary.lerp(other.primary, t),
      primaryVariant: primaryVariant.lerp(other.primaryVariant, t),
      secondary: secondary.lerp(other.secondary, t),
      secondaryVariant: secondaryVariant.lerp(other.secondaryVariant, t),
      neutral: neutral.lerp(other.neutral, t),
      neutralVariant: neutralVariant.lerp(other.neutralVariant, t),
      error: error.lerp(other.error, t),
      errorVariant: errorVariant.lerp(other.errorVariant, t),
    );
  }
}
