import 'package:flutter/rendering.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

final class AppDrinkCardThemeBranch extends FkCustomThemeBranch {
  AppDrinkCardThemeBranch(super.ownerTheme);

  @override
  String get name => "DrinkCard";

  @override
  FkTheme get theme => isLight ? _light : _dark;

  FkTheme get _dark {
    return ownerTheme.copyWith(
      defaultTextColor: (colorPalete) => colorPalete.neutralVariant.onShade300,
      decoration: BoxDecoration(
        color: ownerTheme.colorPalete.neutral,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  FkTheme get _light {
    return ownerTheme.copyWith(
      defaultTextColor: (colorPalete) => colorPalete.neutralVariant.onShade300,
      decoration: BoxDecoration(
        color: ownerTheme.colorPalete.neutral,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
