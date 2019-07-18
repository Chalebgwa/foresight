import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("foresight"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.signInAlt),
            onPressed: () {},
          )
        ],
      ),
      body: AnimatedBackground(
        behaviour: SpaceBehaviour(),
        vsync: this,
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Flexible(
              child: Container(
                width: 300,
                //color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Image(
                        color: Colors.green,
                        image: AssetImage("assets/splash.png"),
                        height: 100,
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: buildTextField(),
                        height: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: buildTextField(),
                        height: 35,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text("Sign In"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField buildTextField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
