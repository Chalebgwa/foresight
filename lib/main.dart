import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foresight/fancy_theme.dart';
import 'package:foresight/root.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: lightFancy.data,
        home: Root() //Service()
        );
  }
}
