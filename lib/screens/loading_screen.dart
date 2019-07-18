import 'package:flutter/material.dart';
import 'package:fluttie/fluttie.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  FluttieAnimationController shockedEmoji;

  bool ready = false;

  bool showPerformanceOverlay = false;

  @override
  initState() {
    super.initState();
    prepareAnimation();
  }

  @override
  dispose() {
    super.dispose();
    shockedEmoji?.dispose();
  }

  // async because the plugin will have to do some background-work
  prepareAnimation() async {
    // Checks if the platform we're running on is supported by the animation plugin
    bool canBeUsed = await Fluttie.isAvailable();
    if (!canBeUsed) {
      print("Animations are not supported on this platform");
      return;
    }

    var instance = Fluttie();

    // Load our first composition for the emoji animation
    var emojiComposition =
        await instance.loadAnimationFromAsset("assets/animations/favo.json");

    shockedEmoji = await instance.prepareAnimation(
      emojiComposition,
      duration: const Duration(seconds: 2),
      repeatCount: const RepeatCount.infinite(),
      repeatMode: RepeatMode.REVERSE,
      preferredSize: Size(300, 300),
    );

    if (mounted) {
      setState(() {
        ready = true; // The animations have been loaded, we're ready
        shockedEmoji.start(); //start our looped emoji animation
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FluttieAnimation(shockedEmoji),
            Text(
              "created by Cignx",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
