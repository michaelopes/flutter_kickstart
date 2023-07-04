import 'package:example/business/models/drink_model.dart';
import 'package:example/business/services/drink_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

class DrinkViewModel extends FkViewModel<_DrinkViewModelReactive> {
  DrinkViewModel() : super(reactive: _DrinkViewModelReactive());

  late final _drinkService = locator.get<IDrinkService>();

  late final _deboucer = FkDebouncer(
    duration: const Duration(milliseconds: 800),
    onValue: _onSearch,
  );

  final searchEditingController = TextEditingController();

  set seletedDrink(DrinkModel value) => addModuleValue("SelectedDrink", value);

  @override
  Future<void> init() async {
    searchEditingController.addListener(() {
      var term = searchEditingController.text.trim();
      if (term.isEmpty) {
        reactive.drinks.clear();
      } else {
        _deboucer.value = term;
      }
    });
  }

  Future<void> _onSearch(String term) async {
    setLoading(true);
    try {
      reactive.drinks.clear();
      reactive.drinks.addAll(
        await _drinkService.searchDrinks(term),
      );
    } catch (e, s) {
      setError(e, s);
    } finally {
      setLoading(false);
    }
  }
}

class _DrinkViewModelReactive extends FkReactive {
  @override
  init() {
    drinks = FkList.of([]);
  }

  set drinks(FkList<DrinkModel> value);
  FkList<DrinkModel> get drinks;
}
