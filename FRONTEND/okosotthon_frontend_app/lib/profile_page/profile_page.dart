import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/home_page/get_devices_to_list.dart';
import 'package:okosotthon_frontend_app/login_page/login_page.dart';
import 'package:okosotthon_frontend_app/models/device.dart';
import 'package:okosotthon_frontend_app/models/module.dart';
import 'package:okosotthon_frontend_app/profile_page/profile_page_functions.dart';
import 'package:okosotthon_frontend_app/shared/InputFields.dart';
import 'package:okosotthon_frontend_app/shared/Shared_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController emailCont = TextEditingController();
  TextEditingController pwCont = TextEditingController();
  TextEditingController pwaCont = TextEditingController();
  TextEditingController unameCont = TextEditingController();
  bool switchOn = true;
  var prefs;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile settings"),
        backgroundColor: Colors.tealAccent.shade100,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("Auto login"),
                    Switch(
                      value: switchOn,
                      onChanged: (bool value) {
                        (prefs as SharedPreferences).setBool(
                          "autoLogin",
                          value,
                        );
                        setState(() {
                          switchOn = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputFields.buildSimpleTextField(
                  unameCont,
                  TextInputType.text,
                  "",
                  "Username",
                  MediaQuery.sizeOf(context).width * 0.5,
                ),
                SizedBox(width: 10,),
                Column(
                  children: [
                    SizedBox(height: 40,),
                    InputFields.buildCustomizedButton(
                      "Change username",
                      Colors.green,
                      Colors.black,
                      () => {_handleUsernameChange()},
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            Text("Change password"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputFields.buildPasswdField(
                  pwCont,
                  "",
                  "New Password",
                  MediaQuery.sizeOf(context).width * 0.4,
                ),
                SizedBox(width: 10),
                InputFields.buildPasswdField(
                  pwaCont,
                  "",
                  "New Password again",
                  MediaQuery.sizeOf(context).width * 0.4,
                ),
              ],
            ),
            InputFields.buildCustomizedButton(
              "Change password",
              Colors.green,
              Colors.black,
              () => {_handlePasswordChange()},
            ),
            Divider(),
            InputFields.buildEmailField(
              emailCont,
              MediaQuery.sizeOf(context).width * 0.8,
            ),
            InputFields.buildCustomizedButton(
              "Update e-mail address",
              Colors.green,
              Colors.black,
              () => {_handleEmailChange()},
            ),
            Divider(),
            InputFields.buildCustomizedButton(
              "Delete account",
              Colors.red,
              Colors.white,
              () => {_handleAccountDelete()},
            ),
          ],
        ),
      ),
    );
  }

  void _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    bool swOn = prefs.getBool("autoLogin") as bool;
    setState(() {
      this.prefs = prefs;
      this.switchOn = swOn;
      this.unameCont.text = prefs.getString("uname") as String;
      this.emailCont.text = prefs.getString("email") as String;
    });
  }

  void _handleAccountDelete() {
    Shared.buildChoiceDialog(
      context,
      "Warning",
      "Are you shure you want to delete your account? You will loose all of your devices.",
      () {
        _handleAccountDeleteAsync();
      },
      () {
        Navigator.pop(context);
      },
    );
  }

  void _handleEmailChange() async {
    try {
      await ProfilePageFunctions.handleEmailChange(emailCont.text, prefs);
    } catch (e) {
      Shared.showCustomDialog(context, "Error", e.toString().split(":")[1]);
      return;
    }
    ProfilePageFunctions.navigateToLogin(context);
  }

  void _handlePasswordChange() async {
    try {
      await ProfilePageFunctions.handlePasswordChange(
        pwCont.text,
        pwaCont.text,
        prefs,
      );
    } catch (e) {
      Shared.showCustomDialog(context, "Error", e.toString().split(":")[1]);
      return;
    }
    ProfilePageFunctions.navigateToLogin(context);
  }

  void _handleAccountDeleteAsync() async {
    try {
      await ProfilePageFunctions.handleAccountDelete(prefs);
    } catch (e) {
      Shared.showCustomDialog(context, "Error", e.toString()/*.split(":")[1]*/);
      return;
    }
    ProfilePageFunctions.navigateToLogin(context);
  }

  void _handleUsernameChange() async {
    try {
      await ProfilePageFunctions.handleUsernameChange(unameCont.text, prefs);
    } catch (e) {
      Shared.showCustomDialog(context, "Error", e.toString().split(":")[1]);
      return;
    }
  }
}
