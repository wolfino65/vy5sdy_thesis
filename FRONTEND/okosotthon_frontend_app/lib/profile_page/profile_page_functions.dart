import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/home_page/get_devices_to_list.dart';
import 'package:okosotthon_frontend_app/login_page/login_page.dart';
import 'package:okosotthon_frontend_app/models/device.dart';
import 'package:okosotthon_frontend_app/models/module.dart';
import 'package:okosotthon_frontend_app/shared/Shared_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePageFunctions {
  static void navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  static Future<void> handleAccountDelete(SharedPreferences prefs) async {
    String userId = prefs.getString("id") as String;
    List<Device> devices =
        await DeviceFetcher.getDevicesByOwner() as List<Device>;
    for (Device device in devices) {
      await Shared.scheduleTask(
        device.id,
        Module.empty(),
        "disown",
        userId,
        {},
      );
      await http.delete(
        Uri.parse("http://158.180.52.252:4500/device/deleteDevice"),
        headers: <String, String>{"dev_id": device.id},
      );
    }

    final resp = await http.delete(
      Uri.parse("http://158.180.52.252:4500/user/deleteUser"),
      headers: <String, String>{"user_id": userId},
    );
    if (resp.statusCode != 200) {
      throw Exception("We were unable to delete the account.");
    }
  }

  static Future<void> handlePasswordChange(
    String pw,
    String pwa,
    SharedPreferences prefs,
  ) async {
    if (pw != pwa) {
      throw Exception("Passwords do not match.");
    }
    pw = sha256.convert(utf8.encode(pw)).toString();
    final resp = await http.put(
      Uri.parse("http://158.180.52.252:4500/user/updateUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "user_id": prefs.getString("id") as String,
        "newInfo": {"password": pw},
      }),
    );
    if (resp.statusCode != 200) {
      throw Exception("We could not change your password.");
    }
  }

  static Future<void> handleEmailChange(
    String email,
    SharedPreferences prefs,
  ) async {
    final resp = await http.put(
      Uri.parse("http://158.180.52.252:4500/user/updateUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "user_id": prefs.getString("id") as String,
        "newInfo": {"email": email},
      }),
    );
    if (resp.statusCode != 200) {
      throw Exception("We could not change your e-mail address.");
    }
  }

  static Future<void> handleUsernameChange(
    String username,
    SharedPreferences prefs,
  ) async {
    final resp = await http.put(
      Uri.parse("http://158.180.52.252:4500/user/updateUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "user_id": prefs.getString("id") as String,
        "newInfo": {"username": username},
      }),
    );
    if (resp.statusCode != 200) {
      throw Exception("We could not change your username.");
    }
    prefs.setString("uname", username);
  }
}
