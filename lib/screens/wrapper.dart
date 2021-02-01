import 'package:flutter/material.dart';
import 'package:gang_brew_crew/models/custom_user.dart';
import 'package:gang_brew_crew/screens/authenticate/authenticate.dart';
import 'package:gang_brew_crew/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    // return home or auth widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
