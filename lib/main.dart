import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gang_brew_crew/models/custom_user.dart';
import 'package:gang_brew_crew/screens/wrapper.dart';
import 'package:gang_brew_crew/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
