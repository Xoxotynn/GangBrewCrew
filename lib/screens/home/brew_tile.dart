import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gang_brew_crew/models/brew.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;

  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Card(
        shape: SuperellipseShape(borderRadius: BorderRadius.circular(16.0)),
        margin: EdgeInsets.symmetric(horizontal: 24.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 24.0,
            backgroundImage: AssetImage("assets/coffee_icon.png"),
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text("Takes ${brew.sugars} sugars"),
        ),
      ),
    );
  }
}
