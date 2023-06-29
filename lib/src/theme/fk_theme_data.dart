import 'fk_theme.dart';

class FkThemeData {
  final FkTheme light;
  final FkTheme dark;

  FkThemeData({
    required this.light,
    required this.dark,
  });

  factory FkThemeData.single({
    required FkTheme data,
  }) {
    return FkThemeData(
      light: data,
      dark: data,
    );
  }
}
