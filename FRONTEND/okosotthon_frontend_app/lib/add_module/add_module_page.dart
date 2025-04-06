import 'package:flutter/material.dart';

class AddModule extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_AddModuleState();
}

class _AddModuleState extends State<AddModule>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add module"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Text("placeholder"),
    );
  }
}