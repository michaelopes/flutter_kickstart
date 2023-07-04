import 'package:example/ui/drink/drink_detail_view.dart';
import 'package:example/ui/drink/drink_view.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import '../ui/drink/drink_detail_viewmodel.dart';
import '../ui/drink/drink_viewmodel.dart';
import '../ui/use_assets/use_assets_view.dart';
import '../ui/use_assets/use_assets_viewmodel.dart';
import '../ui/settings/use_responsive_view.dart';
import '../ui/settings/use_responsive_viewmodel.dart';
import '../ui/splash/splash_view.dart';
import '../ui/splash/splash_viewmodel.dart';
import '../ui/typography/typography_view.dart';
import '../ui/typography/typography_viewmodel.dart';
import '../ui/widgets/initial_navigator.dart';

class AppModules {
  static const splash = "/";
  static const typography = "/typography";
  static const useAssets = "/use-assets";
  static const useResponsive = "/use-responsive";

  static const drink = "/drink";
  static const drinkDetail = "/drink-detail";

  List<FkBaseModule> get modules {
    return [
      FkModule.singleView(
        path: splash,
        builder: (context, goRouterStat) => SplashView(),
        viewModelFactory: () => SplashViewModel(),
      ),
      FkModuleGroup(
        builder: (_, __, child) {
          return InitialNavigator(child: child);
        },
        modules: [
          FkModule.singleView(
            path: typography,
            builder: (context, goRouterStat) => TypographyView(),
            viewModelFactory: TypographyViewModel.new,
          ),
          FkModule.singleView(
            path: useAssets,
            builder: (context, goRouterStat) => UseAssetsView(),
            viewModelFactory: UseAssetsViewModel.new,
          ),
          FkModule.singleView(
            path: useResponsive,
            builder: (context, goRouterStat) => UseResponsiveView(),
            viewModelFactory: UseResponsiveViewModel.new,
          ),
          FkModule(
            views: [
              FkModuleView(
                path: drink,
                builder: (context, goRouterStat) => DrinkView(),
                viewModelFactory: DrinkViewModel.new,
              ),
              FkModuleView(
                path: drinkDetail,
                builder: (context, goRouterStat) => DrinkDetailView(),
                viewModelFactory: DrinkDetailViewModel.new,
              )
            ],
          )
        ],
      )
    ];
  }
}
