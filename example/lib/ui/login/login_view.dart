import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import 'login_viewmodel.dart';

class LoginView extends FkView<LoginViewModel> {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await vm.appSimulateLogin();
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
