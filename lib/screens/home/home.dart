import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gang_brew_crew/models/brew.dart';
import 'package:gang_brew_crew/screens/home/brew_list.dart';
import 'package:gang_brew_crew/screens/home/settings_form.dart';
import 'package:gang_brew_crew/screens/home/settings_sheet_collapsed.dart';
import 'package:gang_brew_crew/services/auth.dart';
import 'package:gang_brew_crew/services/database.dart';
import 'package:gang_brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.brown[300],
          elevation: 0.0,
          title: Text("Home"),
          leading: FlatButton(
            child: Icon(
              CupertinoIcons.reply,
              color: Colors.white,
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ),
        body: SlidingUpPanel(
          parallaxEnabled: true,
          minHeight: 64.0,
          backdropEnabled: true,
          controller: panelController,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          panel: SettingsForm(),
          body: BrewList(),
          collapsed: SettingsSheetCollapsed(),
        ),
      ),
    );
  }
}
