import 'dart:convert';

class DrinkModel {
  final String id;
  final String name;
  final String thumbnail;
  final String instructions;
  final List<String> ingredients;
  DrinkModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.instructions,
    required this.ingredients,
  });

  factory DrinkModel.fromMap(Map<String, dynamic> map) {
    var ingredients = <String>[];
    for (var i = 1; i <= 15; i++) {
      if (map['strIngredient$i'] != null && map['strIngredient$i'] != "null") {
        ingredients.add("${map['strIngredient$i']} - ${map['strMeasure$i']}");
      }
    }

    return DrinkModel(
      id: map['idDrink'],
      name: map['strDrink'],
      thumbnail: map['strDrinkThumb'],
      instructions: map['strInstructions'],
      ingredients: ingredients,
    );
  }

  factory DrinkModel.fromJson(String source) =>
      DrinkModel.fromMap(json.decode(source));
}
