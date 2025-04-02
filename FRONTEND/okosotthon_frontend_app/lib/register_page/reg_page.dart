import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/input/InputFields.dart';
import 'package:okosotthon_frontend_app/shared/Shared_functions.dart';
import 'package:okosotthon_frontend_app/register_page/registration.dart';

class RegPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController emailCont = new TextEditingController();
  TextEditingController pwCont = new TextEditingController();
  TextEditingController pwAgainCont = new TextEditingController();
  TextEditingController unameCont = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.lightBlue.shade200,
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: 800,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.green, Colors.lightBlue.shade200],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 800,
              child: InputFields.buildEmailField(
                emailCont,
                MediaQuery.sizeOf(context).width * 0.8,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 800,
              child: InputFields.buildPasswdField(
                pwCont,
                "Password",
                "Password",
                MediaQuery.sizeOf(context).width * 0.8,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 800,
              child: InputFields.buildPasswdField(
                pwAgainCont,
                "Password again",
                "Password again",
                MediaQuery.sizeOf(context).width * 0.8,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 800,
              child: InputFields.buildSimpleTextField(
                unameCont,
                TextInputType.name,
                "Username",
                "",
                MediaQuery.sizeOf(context).width * 0.8,
              ),
            ),
            SizedBox(height: 100),
            InputFields.buildCustomizedButton(
              "Register",
              Colors.blueGrey.shade700,
              Colors.white,
              () => _registerUser(),
            ),
          ],
        ),
      ),
    );
  }

  void _registerUser() async {
    if (pwCont.text != pwAgainCont.text) {
      Shared.showCustomDialog(
        context,
        "Does not match.",
        "The two passwords do not match!",
      );
      return;
    }
    final s = await Registration.registerUser(
      pwCont.text,
      emailCont.text,
      unameCont.text,
    );
    if (s == "true") {
      Navigator.pop(context);
      Shared.showCustomDialog(context, "Success", "Succesfull registration!");
    } else {
      Shared.showCustomDialog(context, "Error", "Unsuccesfull registration!\n$s");
    }
  }
}
