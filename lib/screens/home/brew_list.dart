import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gang_brew_crew/models/brew.dart';
import 'package:gang_brew_crew/screens/home/brew_tile.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];

    return ListView.builder(
      padding: EdgeInsets.only(top: 32.0),
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
