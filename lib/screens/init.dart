import 'package:flutter/material.dart';
import 'package:foresight/screens/inbox.dart';
import 'package:foresight/screens/profile.dart';
import 'package:foresight/screens/stores.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';

class Init extends StatefulWidget {
  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
      typeOpen: TypeOpen.FROM_RIGHT,
      curveAnimation: Curves.easeOut,
      menu: Menu(),
      screenSelectedBuilder: (position, controller) {
        Widget screenCurrent;
        switch (position) {
          case 0:
            screenCurrent = HomePage(
              controller: controller,
            );
            break;
          case 1:
            screenCurrent = ProfileView(
              controller: controller,
            );
            break;
          case 2:
            screenCurrent = InboxView(
              controller: controller,
            );
            break;
        }

        return Scaffold(
          body: screenCurrent,
        );
      },
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin {
  AnimationController _animationController;
  bool initConfigState = false;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    confListenerState(context);

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage("assets/back/back3.jpg"),
            ),
          ),
        ),
        FadeTransition(
          opacity: _animationController,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildDrawerTile(context, 0, "Home"),
                  buildDrawerTile(context, 1, "Profile"),
                  buildDrawerTile(context, 2, "Chat"),
                  buildDrawerTile(context, 1, "Settings"),
                  buildDrawerTile(context, 1, "Share"),
                  buildDrawerTile(context, 1, "Logout"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox buildDrawerTile(BuildContext context, int index, String title) {
    return SizedBox(
      width: 200.0,
      child: RaisedButton(
        //color: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        onPressed: () {
          SimpleHiddenDrawerProvider.of(context).setSelectedMenuPosition(index);
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void confListenerState(BuildContext context) {
    if (!initConfigState) {
      initConfigState = true;
      SimpleHiddenDrawerProvider.of(context)
          .getMenuStateListener()
          .listen((state) {
        if (state == MenuState.open) {
          _animationController.forward();
        }

        if (state == MenuState.closing) {
          _animationController.reverse();
        }
      });
    }
  }
}
