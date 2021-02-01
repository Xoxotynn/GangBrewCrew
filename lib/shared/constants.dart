import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final textInputDecoration = InputDecoration(
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
  fillColor: CupertinoColors.systemGrey5,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown[100], width: 1.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown[200], width: 2.0)),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown[200], width: 2.0)),
);

PanelController panelController = PanelController();


