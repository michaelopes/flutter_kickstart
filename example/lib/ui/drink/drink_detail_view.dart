import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import 'drink_detail_viewmodel.dart';

class DrinkDetailView extends FkView<DrinkDetailViewModel> {
  DrinkDetailView({super.key});

  dynamic get pageTr => tr.pages.drink_detail;

  Widget get _buildInstructions {
    return Column(
      children: [
        Text(
          pageTr.instructions(),
          style: theme.typography.headline05,
        ),
        SizedBox(
          width: 400,
          child: Text(
            vm.drink.instructions,
            textAlign: TextAlign.center,
            style: theme.typography.bodySmall,
          ),
        ),
      ],
    );
  }

  Widget get _buildIngredients {
    return Column(
      children: [
        Text(
          pageTr.ingredients(),
          style: theme.typography.headline05,
        ),
        ...vm.drink.ingredients
            .map((e) => Text(
                  e,
                  style: theme.typography.bodySmall,
                ))
            .toList()
      ],
    );
  }

  Widget get _buildContent {
    return Column(
      children: [
        Image.network(vm.drink.thumbnail),
        const SizedBox(
          height: 32,
        ),
        _buildIngredients,
        const SizedBox(
          height: 32,
        ),
        _buildInstructions,
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.drink.name),
      ),
      body: SingleChildScrollView(
        child: FkResponsiveLayout.builderByDevice(
          mobile: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildContent,
          ),
          tablet: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: _buildContent,
          ),
          desktop: (_, __) => Center(
            child: SizedBox(
              width: 992,
              child: _buildContent,
            ),
          ),
        ),
      ),
    );
  }
}
