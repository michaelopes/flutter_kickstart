import 'package:example/assets_snippeds/app_animations.dart';
import 'package:example/assets_snippeds/app_icons.dart';
import 'package:example/assets_snippeds/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import 'branchs/app_vertical_card_theme_branch.dart';

class AppTheme {
  final _colorPalete = FkColorPalete(
    primary: FkColor(
      target: (thiz) => thiz.shade400,
      shade50: const Color(0xFFFFF8ED),
      shade100: const Color(0xFFFFEFD5),
      shade200: const Color(0xFFFFDBA9),
      shade300: const Color(0xFFFEC173),
      shade400: const Color(0xFFfc9631),
      shade500: const Color(0xFFFA7E15),
      shade600: const Color(0xFFEB630B),
      shade700: const Color(0xFFC34A0B),
      shade800: const Color(0xFF9b3b11),
      shade900: const Color(0xFF7d3211),
    ),
  );

  final _neutral1 = FkColor(
    target: (thiz) => thiz.shade100,
    shade50: const Color(0xFF000000),
    shade100: const Color(0xFF000000),
    shade200: const Color(0xFF1C1C1C),
    shade300: const Color(0xFF393939),
    shade400: const Color(0xFF555555),
    shade500: const Color(0xFF717171),
    shade600: const Color(0xFF8E8E8E),
    shade700: const Color(0xFFAAAAAA),
    shade800: const Color(0xFFC6C6C6),
    shade900: const Color(0xFFF3F3F3),
  );

  final _neutral2 = FkColor(
    target: (thiz) => thiz.shade100,
    shade50: const Color(0xFFFFFFFF),
    shade100: const Color(0xFFFFFFFF),
    shade200: const Color(0xFFF3F3F3),
    shade300: const Color(0xFFE3E3E3),
    shade400: const Color(0xFFC6C6C6),
    shade500: const Color(0xFFAAAAAA),
    shade600: const Color(0xFF8E8E8E),
    shade700: const Color(0xFF717171),
    shade800: const Color(0xFF555555),
    shade900: const Color(0xFF393939),
  );

  final iconsDirectory = "assets/icons/";
  final imagesDirectory = "assets/images/";
  final animationsDirectory = "assets/animations/";

  final assetsSnippets = <FkAssetSnippetProvider>[
    AppAnimationsSnippets(),
    AppIconsSnippets(),
    AppImagesSnippets()
  ];

  FkTheme get light {
    return FkTheme.light(
      colorPalete: _colorPalete.copyWith(
        neutral: _neutral1,
        neutralVariant: _neutral2,
      ),
      iconsDirectory: iconsDirectory,
      imagesDirectory: imagesDirectory,
      animationsDirectory: animationsDirectory,
      background: (colorPalete) => colorPalete.neutralVariant,
      assetsSnippets: assetsSnippets,
      bottomNavigationBarTheme: (colorPalete) {
        return BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: colorPalete.primary,
          unselectedItemColor: colorPalete.neutral,
          backgroundColor: colorPalete.neutral.shade900,
        );
      },
      inputDecorationTheme: (colorPalete) {
        return InputDecorationTheme(
          labelStyle: TextStyle(
            color: colorPalete.neutral.onShade200,
          ),
          hintStyle: TextStyle(
            color: colorPalete.neutral.onShade400,
          ),
          fillColor: colorPalete.neutralVariant.shade200,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorPalete.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorPalete.neutralVariant.shade200,
            ),
          ),
        );
      },
      themeBranchs: (owner) {
        return [
          AppVerticalCardThemeBranch(owner),
        ];
      },
    );
  }

  FkTheme get dark {
    return FkTheme.dark(
      colorPalete: _colorPalete.copyWith(
        neutral: _neutral2,
        neutralVariant: _neutral1,
      ),
      iconsDirectory: iconsDirectory,
      imagesDirectory: imagesDirectory,
      animationsDirectory: animationsDirectory,
      background: (colorPalete) => colorPalete.neutralVariant,
      assetsSnippets: assetsSnippets,
      bottomNavigationBarTheme: (colorPalete) {
        return BottomNavigationBarThemeData(
          selectedItemColor: colorPalete.primary,
          unselectedItemColor: colorPalete.neutral,
        );
      },
      inputDecorationTheme: (colorPalete) {
        return InputDecorationTheme(
          labelStyle: TextStyle(
            color: colorPalete.neutral.onShade200,
          ),
          hintStyle: TextStyle(
            color: colorPalete.neutral.onShade300,
          ),
          fillColor: colorPalete.neutralVariant.onShade200,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorPalete.primary,
            ),
          ),
          enabledBorder: const OutlineInputBorder(),
        );
      },
      themeBranchs: (owner) {
        return [
          AppVerticalCardThemeBranch(owner),
        ];
      },
    );
  }

  FkThemeData get theme => FkThemeData(light: light, dark: dark);
}
