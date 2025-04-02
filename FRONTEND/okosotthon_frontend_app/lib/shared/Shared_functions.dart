import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class Shared {
  static Future<Map<String, dynamic>> loginRequest(
    String email,
    String pw,
  ) async {
    pw = sha256.convert(utf8.encode(pw)).toString();
    final resp = await http.post(
      Uri.parse("http://172.30.16.1:4500/user/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': pw}),
    );

    if (resp.statusCode == 200) {
      return jsonDecode(resp.body) as Map<String, dynamic>;
    } else {
      throw Exception("No data");
    }
  }

  static showCustomDialog(BuildContext context, String title, String content) {
    AlertDialog alert = AlertDialog(title: Text(title), content: Text(content));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
