import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:okosotthon_frontend_app/add_task_page/final_ui_definition.dart';
import 'package:okosotthon_frontend_app/models/module.dart';
import 'package:okosotthon_frontend_app/models/ui.dart';
import 'package:okosotthon_frontend_app/shared/InputFields.dart';

class TaskUiGenerator {

  static Future<Ui> fetchUi(String googleFileId) async{
    String apiKey="<your api key>";
    Uri url = Uri.parse("https://www.googleapis.com/drive/v3/files/$googleFileId?alt=media&key=$apiKey");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Ui.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load UI data');
    }
  }
  static FinalUiDefinition buildUi(Ui ui,BuildContext context)  {
    List<Widget> widgets = [];
    List<String> returnNames = [];
    List<TextEditingController> controllers = [];

    for (var element in ui.elements) {
      switch (element.type) {
        case "number_input":
          TextEditingController tec = TextEditingController();
          controllers.add(tec);
          widgets.add(InputFields.buildSimpleTextField(tec, TextInputType.number,"", element.name, MediaQuery.sizeOf(context).width * 0.8));
          returnNames.add(element.respName);
          break;
        default:
          widgets.add(Text("Unknown type"));
      }
    }
    return FinalUiDefinition(widgets, returnNames, controllers);
  }
}
