//import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Registration {
  static Future<String> registerUser(
    String pw,
    String email,
    String uname,
  ) async {
    pw = sha256.convert(utf8.encode(pw)).toString();
    final resp = await http.post(
      Uri.parse("http://192.168.1.82:4500/user/register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      body: jsonEncode(<String, String>{
        'email': email,
        'password': pw,
        'username': uname,
      }),
    );
    if (resp.statusCode==200) {
      return "true";
    } else {
      return resp.body.toString();
    }
  }
}
