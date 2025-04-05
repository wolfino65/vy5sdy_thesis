import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/device_option_pages/device_options_page/options_page.dart';
import 'package:okosotthon_frontend_app/device_option_pages/update_device_page/update_page.dart';
import 'package:okosotthon_frontend_app/models/device.dart';
import 'package:okosotthon_frontend_app/models/module.dart';
import 'package:okosotthon_frontend_app/shared/Shared_functions.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DevicePage extends StatefulWidget {
  Device dev = Device.empty();
  DevicePage(Device dev) {
    this.dev = dev;
  }
  @override
  State<StatefulWidget> createState() => _DevicePageState(dev);
}

class _DevicePageState extends State<DevicePage> {
  bool deltedFlag = false;
  bool tryedToDeleteFlag = false;
  @override
  void initState() {
    super.initState();
    _getConnectedModules(dev.aditionalInfo.connected);
  }

  List<Module> modules = [];
  Device dev = Device.empty();
  _DevicePageState(Device dev) {
    this.dev = dev;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///////////////////////////
      appBar: AppBar(
        title: Text(dev.deviceName),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry>[
                  const PopupMenuItem(value: 0, child: Text('Update device')),
                  const PopupMenuItem(value: 99, child: Text('Delete device')),
                  const PopupMenuItem(value: 1, child: Text('Device options')),
                ],
            onSelected: (value) {
              _handlePopupMenuChoice(value);
            },
          ),
        ],
      ),

      //////////////////////////
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: SizedBox(
                        height: 100,
                        width: (MediaQuery.sizeOf(context).width * 0.8) / 2,
                        child: Container(
                          color: const Color.fromARGB(204, 255, 0, 0),
                          child: Text(modules[0].name),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: SizedBox(
                        height: 100,
                        width: (MediaQuery.sizeOf(context).width * 0.8) / 2,
                        child: Container(
                          color: const Color.fromARGB(84, 124, 194, 11),
                          child: Text(modules[1].name),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    GestureDetector(
                      child: SizedBox(
                        height: 100,
                        width: (MediaQuery.sizeOf(context).width * 0.8) / 2,
                        child: Container(
                          color: const Color.fromARGB(84, 238, 215, 12),
                          child: Text(modules[2].name),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: SizedBox(
                        height: 100,
                        width: (MediaQuery.sizeOf(context).width * 0.8) / 2,
                        child: Container(
                          color: const Color.fromARGB(82, 22, 19, 206),
                          child: Text(modules[3].name),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {print("pushed")},
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getConnectedModules(List<String> arr) async {
    List<Module> l = [];
    if (this.mounted) {
      Module mod = Module.empty();
      for (var moduleId in arr) {
        if (moduleId == "Unused") {
          mod = Module.empty();
        } else {
          mod = await Shared.getModuleById(moduleId);
        }
        l.add(mod);
      }
      setState(() {
        this.modules = l;
      });
    }
  }

  Future<void> _deleteDevice() async {
    final resp = await http.delete(
      Uri.parse("http://192.168.1.82:4500/device/deleteDevice"),
      headers: <String, String>{"dev_id": dev.id},
    );
    final prefs = await SharedPreferences.getInstance();
    await Shared.scheduleTask(
      dev.id,
      Module.empty(),
      "disown",
      prefs.getString("id") as String,
      {},
    );
    if (resp.statusCode == 200) {
      setState(() {
        deltedFlag = true;
      });
      Navigator.pop(context);
    }
  }

  void _handlePopupMenuChoice(int value) {
    if (value == 99) {
      final deviceName = dev.deviceName;
      Shared.buildChoiceDialog(
        context,
        "Delete device?",
        "Are you shure you want to delete $deviceName?",
        () => {_handleYesChoice()},
        () => {_handleNoChoice()},
      );
      if (deltedFlag) {
        Navigator.pop(context);
      }
      if (!deltedFlag && tryedToDeleteFlag) {
        Shared.showCustomDialog(
          context,
          "Error",
          "We were unable to delete the device.",
        );
      }
      return;
    }
    if (value == 0) {
      _handleReturningData();
    }
    if (value == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DeviceOptions(dev)),
      );
    }
  }

  void _handleYesChoice() {
    _deleteDevice();
    setState(() {
      tryedToDeleteFlag = true;
    });
    Navigator.pop(context);
  }

  void _handleNoChoice() {
    Navigator.pop(context);
  }

  Future<void> _handleReturningData() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateDevice(dev)),
    );
    setState(() {
      dev.deviceName = result[0];
      dev.location = result[1];
    });
  }
}
