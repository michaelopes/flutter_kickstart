import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

class ValidationsViewModel extends FkViewModel {
  ValidationsViewModel() : super(reactive: EmptyReactive());

  final formKey = GlobalKey<FormState>();
  String password = "";
  String email = "";

  @override
  Future<void> init() async {}

  void submit() {
    formKey.currentState?.validate();
  }
}
