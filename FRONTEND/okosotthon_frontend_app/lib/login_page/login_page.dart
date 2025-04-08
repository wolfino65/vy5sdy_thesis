import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/shared/InputFields.dart';
import 'package:okosotthon_frontend_app/register_page/reg_page.dart';
import 'package:okosotthon_frontend_app/home_page/home_page.dart';
import 'package:okosotthon_frontend_app/shared/Shared_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCont = new TextEditingController();
  TextEditingController pwCont = new TextEditingController();
  bool swOn=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: 800,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
            colors: [Colors.green, Colors.lightBlue.shade200],
          ),
        ),
        child: SingleChildScrollView(child: 
         Column(
          children: [
            SizedBox(width: 800, child: InputFields.buildEmailField(emailCont,MediaQuery.sizeOf(context).width*0.8)),
            SizedBox(height: 50),
            SizedBox(
              width: 800,
              child: InputFields.buildPasswdField(
                pwCont,
                "Password",
                "Password",
                MediaQuery.sizeOf(context).width*0.8
              ),
            ),
            Column(
              children: [
                Text("Keep me logged in"),
                SizedBox(height: 20,),
                Switch(value: swOn, onChanged: (bool value){
                    setState(() {
                      swOn=value;
                    });
                })
              ],
            ),
            SizedBox(height: 100),
            InputFields.buildCustomizedButton(
              "Login",
              Colors.greenAccent,
              Colors.purpleAccent,
              () => _login(swOn),
            ),
            SizedBox(height: 50),
            _buildSignIn(),
          ],
        ),
        )
      ),
    );
  }

  void _login(bool autoLogin) async {
    try {
      String pw = sha256.convert(utf8.encode(pwCont.text)).toString();
      final resp = await Shared.loginRequest(emailCont.text,pw );
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', resp['email'].toString());
      prefs.setString('uname', resp['username'].toString());
      prefs.setString('id', resp['_id'].toString());
      prefs.setString('password', resp['password'].toString());
      prefs.setBool('autoLogin', autoLogin);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DeviceList()),
      );
    } catch (e) {
      Shared.showCustomDialog(
        context,
        "Unsuccesfull login.",
        "Wrong email address or password.",
      );
    }
  }

  void _navigateToReg() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegPage()));
  }

  Widget _buildSignIn() {
    return Column(
      children: [
        Text("Don't have an account?"),
        InputFields.buildCustomizedButton(
          "Register",
          Colors.blueGrey.shade700,
          Colors.white,
          () => _navigateToReg(),
        ),
      ],
    );
  }
}
