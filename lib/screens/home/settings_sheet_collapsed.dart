import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gang_brew_crew/models/custom_user.dart';
import 'package:gang_brew_crew/services/database.dart';
import 'package:gang_brew_crew/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

class SettingsSheetCollapsed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    final database = DatabaseService(uid: user.uid);

    return StreamBuilder(
      stream: database.userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.brown[200]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.0,
                ),
                Container(
                  width: 32.0,
                  height: 4.0,
                  decoration: ShapeDecoration(
                    color: Colors.brown[userData.strength],
                    shape: SuperellipseShape(
                        borderRadius: BorderRadius.circular(64.0)),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  userData.name,
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
