import 'package:flutter/material.dart';

class RegPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
    );
  }
}
