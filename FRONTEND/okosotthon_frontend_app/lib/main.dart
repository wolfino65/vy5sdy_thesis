import 'package:flutter/material.dart';
import 'home_page/home_page.dart';
import 'login_page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:okosotthon_frontend_app/shared/Shared_functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool? autoLogin = prefs.getBool('autoLogin');
  if (autoLogin == true) {
    try {
      String? pw = prefs.getString('password');
      String? email = prefs.getString('email');
      Shared.loginRequest(email as String, pw as String);
      runApp(MaterialApp(home: DeviceList()));
    } catch (e) {
      runApp(MaterialApp(home: LoginPage()));
    }
  } else {
    runApp(MaterialApp(home: LoginPage()));
  }
}
