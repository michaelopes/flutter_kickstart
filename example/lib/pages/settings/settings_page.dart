import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';
import 'settings_viewmodel.dart';

class SettingsView extends FkView<SettingsViewModel> {
  SettingsView({super.key});

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr.pages.settings.title(),
        ),
      ),
      body: Container(),
    );
  }
}
