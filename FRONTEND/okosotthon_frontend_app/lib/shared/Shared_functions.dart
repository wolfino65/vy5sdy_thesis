import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/models/module.dart';

class Shared {
  static Future<Map<String, dynamic>> loginRequest(
    String email,
    String pw,
  ) async {
    pw = sha256.convert(utf8.encode(pw)).toString();
    final resp = await http.post(
      Uri.parse("http://192.168.1.82:4500/user/login"),
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

  static Future<Module> getModuleById(String id) async {
    final resp = await http.get(
      Uri.parse("http://192.168.1.82:4500/module/getModuleById"),
      headers: <String, String>{"module_id": id},
    );
    if (resp.statusCode != 200) {
      throw Exception("Could not find module.");
    }
    return Module.fromJson(json.decode(resp.body));
  }

  static Future<void> scheduleTask(
    String devId,
    Module module,
    String method,
    String userId,
    Map<String, dynamic> params,
  ) async {
    final resp = await http.post(
      Uri.parse("http://192.168.1.82:4500/task/addTask"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "dev_id": devId,
        "module_id": module.id,
        "user_id": userId,
        "params": jsonEncode(params),
        "aditionalInfo": {"method": method},
      }),
    );
  }


  static void buildChoiceDialog(BuildContext context,String title, String content, Function yesFunc,Function noFunc){
    AlertDialog question = AlertDialog(title: Text(title), content: Text(content),
      actions: [
        TextButton(onPressed: (){yesFunc();}, child: Text("Yes")),
        TextButton(onPressed: (){noFunc();}, child: Text("No"))
      ],
      );

      showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
        return question;
      });

  }
}
