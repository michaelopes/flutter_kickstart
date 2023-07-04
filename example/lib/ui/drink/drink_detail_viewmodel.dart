import 'package:example/business/models/drink_model.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

abstract interface class IDrinkDetailViewModel {
  DrinkModel get drink;
}

class DrinkDetailViewModel extends FkViewModel
    implements IDrinkDetailViewModel {
  DrinkDetailViewModel() : super(reactive: EmptyReactive());

  @override
  Future<void> init() async {}

  @override
  DrinkModel get drink => getModuleValue("SelectedDrink");
}
