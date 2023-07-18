import 'package:example/setup/app_modules.dart';
import 'package:example/ui/drink/drink_viewmodel.dart';
import 'package:example/ui/widgets/drink_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import '../widgets/reactive_widget.dart';

class DrinkView extends FkView<DrinkViewModel> {
  DrinkView({super.key});

  dynamic get pageTr => tr.pages.drink;

  Widget get _buildSearchInput {
    return TextFormField(
      controller: vm.searchEditingController,
      decoration: InputDecoration(
        labelText: pageTr.search_label(),
        hintText: pageTr.search_placeholder(),
      ),
    );
  }

  Widget get _buildEmptySearch {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: theme.icons.emptySearch(),
        ),
        SizedBox(
          width: 300,
          child: Text(
            pageTr.empty_search_message(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget get _buildNotFound {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: theme.icons.notFound(),
        ),
        SizedBox(
          width: 300,
          child: Text(
            pageTr.not_found_search_message(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget get _buildDrinkList {
    if (vm.loading()) {
      return const Center(child: CircularProgressIndicator());
    } else if (vm.searchEditingController.text.trim().isNotEmpty &&
        vm.reactive.drinks.isEmpty) {
      return _buildNotFound;
    } else if (vm.searchEditingController.text.trim().isEmpty &&
        vm.reactive.drinks.isEmpty) {
      return _buildEmptySearch;
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 34),
          child: FkResponsiveRow(
            mainAxisSpacing: FkResponsiveSpacing(
              xl: 16,
              lg: 16,
              md: 16,
            ),
            crossAxisSpacing: FkResponsiveSpacing(
              xl: 16,
              lg: 16,
              md: 16,
              sm: 16,
            ),
            children: vm.reactive.drinks
                .map(
                  (e) => FkResponsiveCol(
                    md: FkResponsiveSize.col4,
                    lg: FkResponsiveSize.col3,
                    xl: FkResponsiveSize.col2,
                    child: InkWell(
                      onTap: () {
                        vm.seletedDrink = e;
                        nav.push(AppModules.drinkDetail);
                      },
                      child: DrinkCard(
                        drinkName: e.name,
                        drinkThumbnail: e.thumbnail,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    }
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTr.title()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
        child: Column(
          children: [
            _buildSearchInput,
            const SizedBox(
              height: 16,
            ),
            ReactiveWidget(),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return Dialog(
                      child: ReactiveWidget(),
                    );
                  },
                );
              },
              child: const Text("Show dialog"),
            ),
            Expanded(
              child: _buildDrinkList,
            ),
          ],
        ),
      ),
    );
  }
}
