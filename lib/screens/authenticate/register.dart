import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gang_brew_crew/services/auth.dart';
import 'package:gang_brew_crew/shared/constants.dart';
import 'package:gang_brew_crew/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.brown[300],
              elevation: 0.0,
              leading: CupertinoButton(
                onPressed: () => widget.toggleView(),
                child: Icon(
                  CupertinoIcons.back,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "Sign up to Gang",
              ),
            ),
            body: Container(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: "Email"),
                        validator: (val) =>
                            val.length >= 2 ? null : "Email is not correct",
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            textInputDecoration.copyWith(hintText: "Password"),
                        validator: (val) => val.length >= 6
                            ? null
                            : "Password must have at least 6 characters",
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z0-9]")),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        color: Colors.pink[300],
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => isLoading = true);

                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email.trim(), password);

                            if (result == null) {
                              setState(() {
                                error = "Please enter a valid email";
                                isLoading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
