import 'package:example/business/models/drink_model.dart';
import 'package:example/business/repositories/thecocktaildb_repo.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

abstract interface class IDrinkService {
  Future<List<DrinkModel>> searchDrinks(String term);
}

final class DrinkService extends FkBaseService implements IDrinkService {
  late final _drinkRepo = locator.get<ITheCocktailDBRepo>();

  @override
  Future<List<DrinkModel>> searchDrinks(String term) async {
    var resp = await _drinkRepo.searchDrinks(term);
    if (resp.isSuccess) {
      return List.from(resp.data["drinks"] ?? [])
          .map(
            (e) => DrinkModel.fromMap(e),
          )
          .toList();
    } else {
      throw resp.makeFailure();
    }
  }
}
