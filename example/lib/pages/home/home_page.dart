import 'package:example/pages/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

class HomeView extends FkView<HomeViewModel> {
  HomeView({super.key});

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Typography"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hdg01",
                  style: theme.typography.heading01,
                ),
                Text(
                  "Hdg02",
                  style: theme.typography.heading02,
                ),
                Text(
                  "Hdg03",
                  style: theme.typography.heading03,
                ),
                Text(
                  "Hdg04",
                  style: theme.typography.heading04,
                ),
                Text(
                  "Display01",
                  style: theme.typography.display01,
                ),
                Text(
                  "Display02",
                  style: theme.typography.display02,
                ),
                Text(
                  "Display03",
                  style: theme.typography.display03,
                ),
                Text(
                  "Headline01",
                  style: theme.typography.headline01,
                ),
                Text(
                  "Headline02",
                  style: theme.typography.headline02,
                ),
                Text(
                  "Headline03",
                  style: theme.typography.headline03,
                ),
                Text(
                  "Headline04",
                  style: theme.typography.headline04,
                ),
                Text(
                  "Headline05",
                  style: theme.typography.headline05,
                ),
                Text(
                  "Headline06",
                  style: theme.typography.headline06,
                ),
                Text(
                  "BodyExtra",
                  style: theme.typography.bodyExtra,
                ),
                Text(
                  "BodyLarge",
                  style: theme.typography.bodyLarge,
                ),
                Text(
                  "BodyDefault",
                  style: theme.typography.bodyDefault,
                ),
                Text(
                  "BodySmall",
                  style: theme.typography.bodySmall,
                ),
                Text(
                  "BodyMini",
                  style: theme.typography.bodyMini,
                ),
                Text(
                  "BodyTiny",
                  style: theme.typography.bodyTiny,
                ),
                Text(
                  "ButtonExtra",
                  style: theme.typography.buttonExtra,
                ),
                Text(
                  "ButtonLarge",
                  style: theme.typography.buttonLarge,
                ),
                Text(
                  "ButtonDefault",
                  style: theme.typography.buttonDefault,
                ),
                Text(
                  "ButtonSmall",
                  style: theme.typography.buttonSmall,
                ),
                Text(
                  "ButtonMini",
                  style: theme.typography.buttonMini,
                ),
                Text(
                  "ButtonTiny",
                  style: theme.typography.buttonTiny,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
