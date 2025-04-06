import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:okosotthon_frontend_app/models/device.dart';
import 'package:okosotthon_frontend_app/models/module.dart';
import 'package:okosotthon_frontend_app/shared/Shared_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddModule extends StatefulWidget{
  Device dev = Device.empty();

  AddModule(this.dev);
  
  @override
  State<StatefulWidget> createState()=>_AddModuleState(dev);
}

class _AddModuleState extends State<AddModule>{
  Device dev = Device.empty();
  List<Module> _modules=[];

  _AddModuleState(this.dev);

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add module"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: _buildList(context),
    );
  }

  Future<List> _fetchModules() async{
    final resp= await http.get(
      Uri.parse("http://192.168.1.82:4500/module/allModules"),
    );

    final List<dynamic> jsonList = json.decode(resp.body);
    return jsonList.map((jsonItem) {
      try {
        return Module.fromJson(jsonItem);
      } catch (e) {
        print('Error parsing module: $e\nJSON: $jsonItem');
        return Module.empty();
      }
    }).toList();
  }

  Widget _buildList(BuildContext context){
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: _modules.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_modules[index].name),
          onTap: () {_handleAddModule(_modules[index]);
          },
          tileColor: Colors.teal.shade200,
        );
      },
    );
  }

  void _load() async{
   if (this.mounted) {
      final l = await _fetchModules();
      setState(() {
        this._modules = l as List<Module>;
      });
    }
  }

  void _handleAddModule(Module mod) async{
    final prefs = await SharedPreferences.getInstance();
    await Shared.scheduleTask(dev.id, mod, "add_new", prefs.getString("id") as String, {});
    Shared.showCustomDialog(context, "Instruction", "Please plug in the module.");
  }

}