import 'package:flutter/widgets.dart';

import 'package:flutter_kickstart/flutter_kickstart.dart';

class DrinkCard extends FkViewless {
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
  Widget build(BuildContext context) {
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
