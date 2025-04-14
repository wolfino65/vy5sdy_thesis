import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/add_task_page/final_ui_definition.dart';
import 'package:okosotthon_frontend_app/add_task_page/task_ui_generator.dart';
import 'package:okosotthon_frontend_app/models/device.dart';
import 'package:okosotthon_frontend_app/models/module.dart';
import 'package:okosotthon_frontend_app/models/ui.dart';
import 'package:okosotthon_frontend_app/shared/InputFields.dart';
import 'package:okosotthon_frontend_app/shared/Shared_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTask extends StatefulWidget {
  late Device dev;
  late Module mod;

  AddTask(this.dev, this.mod);

  @override
  State<StatefulWidget> createState() => _AddTaskState(dev, mod);
}

class _AddTaskState extends State<AddTask> {
  late FinalUiDefinition finalUiDef;
  late Device dev;
  late Module mod;

  @override
  void initState() {
    super.initState();
    _loadUI();
  }

  _AddTaskState(this.dev, this.mod);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mod.name),
        backgroundColor: Colors.orange.shade400,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(children: finalUiDef.widgets),
            InputFields.buildCustomizedButton(
              "Create task",
              Colors.green,
              Colors.white,
              () {
                _createTask();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadUI() async {
    Ui ui = await TaskUiGenerator.fetchUi(mod.frontID);
    FinalUiDefinition uidef = TaskUiGenerator.buildUi(ui, context);
    setState(() {
      finalUiDef = uidef;
    });
  }

  void _createTask() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> params = {};
    for (int i = 0; i < finalUiDef.controllers.length; i++) {
      String name = finalUiDef.returnNames[i];
      String value = finalUiDef.controllers[i].text;
      params[name] = value;
    }
    Shared.scheduleTask(
      dev.id,
      mod,
      "run",
      prefs.getString('id') as String,
      params,
    );
    Navigator.pop(context);
  }
}
