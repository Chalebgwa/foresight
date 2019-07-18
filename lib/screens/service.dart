import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foresight/wigets/Card.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.maxFinite,
        //height: double.infinity,
        child: ListView(
          children: <Widget>[
            Tile(),
            Tile(),
            Tile(),
            Tile(),
          ],
        ),
      ),
    ));
  }
}
