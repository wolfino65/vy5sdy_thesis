//import 'dart:async';
import 'package:flutter/material.dart';


class DeviceList extends StatefulWidget {
  const DeviceList({super.key});
  @override
  State<StatefulWidget> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your devices'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Text('asd', textDirection: TextDirection.ltr),
          Text('asd', textDirection: TextDirection.ltr),
        ],
      ),
    );
  }
}
