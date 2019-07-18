import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foresight/screens/init.dart';
import 'package:foresight/screens/loading_screen.dart';
import 'package:foresight/screens/sign_in.dart';

enum AuthState { LOADING, SIGNED_IN, SIGNED_OUT }

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  AuthState _authState;
  Timer timer;

  @override
  void initState() {
    super.initState();
    _authState = AuthState.LOADING;
    Duration duration = new Duration(seconds: 10);
    var callBack = () {
      _signedIn();
    };
    timer = new Timer(duration, callBack);
  }

  void _signedIn() {
    setState(() {
      _authState = AuthState.SIGNED_IN;
    });
  }

  void _signedOut() {
    setState(() {
      _authState = AuthState.SIGNED_OUT;
    });
  }

  void _load() {
    setState(() {
      _authState = AuthState.SIGNED_IN;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authState) {
      case AuthState.LOADING:
        return Container(child: LoadingScreen());
      case AuthState.SIGNED_IN:
        return Init();

      case AuthState.SIGNED_OUT:
        return LoginView();
    }
  }
}
