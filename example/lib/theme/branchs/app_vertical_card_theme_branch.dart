import 'package:flutter/rendering.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

final class AppVerticalCardThemeBranch extends FkCustomThemeBranch {
  AppVerticalCardThemeBranch(super.ownerTheme);

  @override
  String get name => "VerticalCard";

  @override
  FkTheme get theme => isLight ? _light : _dark;

  FkTheme get _dark {
    return ownerTheme.copyWith(
      defaultTextColor: (colorPalete) => ownerTheme.colorPalete.neutral,
      decoration: BoxDecoration(
        color: ownerTheme.colorPalete.neutral.onShade800,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  FkTheme get _light {
    return ownerTheme.copyWith(
      defaultTextColor: (colorPalete) => colorPalete.neutral,
      decoration: BoxDecoration(
        color: ownerTheme.colorPalete.neutralVariant.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
