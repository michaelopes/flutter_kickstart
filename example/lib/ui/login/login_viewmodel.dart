import 'package:example/app_reactive.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends FkViewModel with AppReactive {
  LoginViewModel() : super(reactive: EmptyReactive());
  @override
  void init() {}

  Future<void> appSimulateLogin() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("LOGIN_KEY", true);
    global.isLogged = true;
  }
}
