import 'package:flutter/widgets.dart';

import 'package:flutter_kickstart/flutter_kickstart.dart';

class DrinkCard extends FkSimpleView {
  DrinkCard({
    super.key,
    required this.drinkName,
    required this.drinkThumbnail,
  });

  final String drinkName;
  final String drinkThumbnail;

  @override
  String get themeBranch => "VerticalCard";

  @override
  Widget builder(BuildContext context) {
    return Container(
      decoration: theme.decoration,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: theme.decoration!.borderRadius,
            child: Image.network(drinkThumbnail),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Text(
              drinkName,
              style: theme.typography.bodyExtra,
            ),
          )
        ],
      ),
    );
  }
}
