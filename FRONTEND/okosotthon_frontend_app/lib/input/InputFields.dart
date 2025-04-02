import 'package:flutter/material.dart';

class InputFields {
  static Widget buildEmailField(
    TextEditingController tec, [
    double width = double.infinity,
    Color fillColor = Colors.deepPurpleAccent,
  ]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: <Widget>[
        Text("Email"),
        SizedBox(height: 20.0),
        SizedBox(
          width: width,
          child: TextField(
            controller: tec,
            keyboardType: TextInputType.emailAddress,
            decoration: new InputDecoration(
              hintText: "Email Address",
              fillColor: fillColor,
              filled: true,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildPasswdField(
     TextEditingController tec,
    String topText,
    String hintText, [
    double width = double.infinity,
    
    Color fillColor = Colors.deepPurpleAccent,
  ]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(topText),
        SizedBox(height: 20.0),
        SizedBox(
          width: width,
          child: TextField(
            controller: tec,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration.collapsed(
              hintText: hintText,
              fillColor: fillColor,
              filled: true,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildCustomizedButton(
    String buttonText,
    Color buttonColor,
    Color buttonForegroundColor,
    Function onPressedFunc,
  ) {
    return Container(
      child: ElevatedButton(
        onPressed: ()=>{onPressedFunc()},
        child: Text(buttonText),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(buttonColor),
          foregroundColor: WidgetStatePropertyAll<Color>(buttonForegroundColor),
        ),
      ),
    );
  }

  static Widget buildSimpleTextField(
    TextEditingController tec,
    TextInputType type, [
    String topText = "",
    String hintText = "",
    double width = double.infinity,
    Color fillColor = Colors.deepPurpleAccent,
  ]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(topText),
        SizedBox(height: 20.0),
        SizedBox(
          width: width,
          child: TextField(
            controller: tec,
            keyboardType: type,

            decoration: InputDecoration(
              hintText: hintText,
              fillColor: fillColor,
              filled: true,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
