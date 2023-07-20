import 'package:flutter_kickstart/flutter_kickstart.dart';

abstract interface class ITheCocktailDBRepo {
  Future<FkHttpDriverResponse> searchDrinks(String term);
}

final class TheCocktailDBRepo extends FkBaseRepository
    implements ITheCocktailDBRepo {
  @override
  Future<FkHttpDriverResponse> searchDrinks(String term) {
    //BASE URL IS SETTED ON main.dart
    return httpDriver.get(
      "/v1/1/search.php",
      queryParameters: {
        "s": term,
      },
    );
  }
}
