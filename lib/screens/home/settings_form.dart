import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gang_brew_crew/models/custom_user.dart';
import 'package:gang_brew_crew/services/database.dart';
import 'package:gang_brew_crew/shared/constants.dart';
import 'package:gang_brew_crew/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = [
    '0',
    '1',
    '2',
    '3',
    '4',
  ];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    final database = DatabaseService(uid: user.uid);

    return StreamBuilder<UserData>(
      stream: database.userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return Container(
            padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 48.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Brew Settings",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(hintText: "Name"),
                    validator: (val) =>
                        val.isNotEmpty ? null : "Please enter a name",
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Sugars",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  CupertinoSlidingSegmentedControl(
                    children: Map.fromIterables(sugars, sugars.map((sugar) {
                      return Container(
                        height: 48.0,
                        width: 48.0,
                        child: Center(
                          child:
                              Text("$sugar", style: TextStyle(fontSize: 22.0)),
                        ),
                      );
                    })),
                    onValueChanged: (val) =>
                        setState(() => _currentSugars = val),
                    groupValue: _currentSugars ?? userData.sugars,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Strength of coffee",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Container(
                    width: 512,
                    child: CupertinoSlider(
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      thumbColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      color: Colors.lightGreen[500],
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          panelController.close();

                          await database.updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                        }
                      }),
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
