import 'package:example/business/repositories/thecocktaildb_repo.dart';
import 'package:example/business/services/drink_service.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

class AppInjections {
  void _services() {
    FkInject.I.add<IDrinkService>(() => DrinkService());
  }

  void _repositories() {
    FkInject.I.add<ITheCocktailDBRepo>(() => TheCocktailDBRepo());
  }

  List<void Function()> get() {
    return [
      _repositories,
      _services,
    ];
  }
}
