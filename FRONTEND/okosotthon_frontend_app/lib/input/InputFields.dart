import 'package:flutter/material.dart';

class InputFields {
  static Widget buildEmailField(TextEditingController tec) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: <Widget>[
        Text("Email"),
        SizedBox(height: 20.0),
        TextField(
          controller: tec,
          keyboardType: TextInputType.emailAddress,
          decoration: new InputDecoration.collapsed(hintText: "Email Address",),
        ),
      ],
    );
  }

  static Widget buildPasswdField(TextEditingController tec){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Password"),
        SizedBox(height: 20.0),
        TextField(
          controller: tec,
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration.collapsed(hintText: "Password",),
        ),
      ]
    );
  }

  static Widget buildCustomizedButton(String buttonText, Color buttonColor,Color buttonForegroundColor,Function onPressedFunc){
    return Container(
      child: ElevatedButton(onPressed: ()=>{onPressedFunc()}, child: Text(buttonText),style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(buttonColor),
        foregroundColor: WidgetStatePropertyAll<Color>(buttonForegroundColor)
      ),),
    );
  }

  
}
