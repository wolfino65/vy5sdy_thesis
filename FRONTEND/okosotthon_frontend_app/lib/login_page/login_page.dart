import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/input/InputFields.dart';
import 'package:okosotthon_frontend_app/register_page/reg_page.dart';
import 'package:okosotthon_frontend_app/home_page/home_page.dart';
import 'package:okosotthon_frontend_app/shared/Shared_functions.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCont = new TextEditingController();
  TextEditingController pwCont = new TextEditingController();
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
        child: Column(
          children: [
            SizedBox(width: 800, child: InputFields.buildEmailField(emailCont)),
            SizedBox(height: 50),
            SizedBox(width: 800, child: InputFields.buildPasswdField(pwCont)),
            SizedBox(height: 100),
            InputFields.buildCustomizedButton(
              "Login",
              Colors.greenAccent,
              Colors.purpleAccent,
              () => _login(),
            ),
            SizedBox(height: 50),
            _buildSignIn(),
          ],
        ),
      ),
    );
  }

  void _login() async {
    try {
      final resp = await Shared.loginRequest(emailCont.text, pwCont.text);
      print(resp["_id"].toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DeviceList()),
      );
    } catch (e) {
      print("not succesfull");
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
