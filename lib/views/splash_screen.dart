import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:travelapp/views/onboarding.dart';

import '../widgets/components.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
  }

  bool play = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          Center(
            child: Center(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: 150.0,
                        width: 200.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/splash.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ), // width: MediaQuery.of(context).size.width,
                    Center(
                      child: Container(
                        color: Colors.white,
                        width: 250.0,
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 30.0,
                            color: ButtonAndIconsColor(),
                            fontFamily: 'Horizon',
                          ),
                          child: Center(
                            child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              animatedTexts: [
                                TypewriterAnimatedText('EGYPT TOURS'),
                                TypewriterAnimatedText('Exploring Egypt '),
                                TypewriterAnimatedText('is easier now'),
                              ],
                              onFinished: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const onboarding()),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void goToMainScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const onboarding();
    }));
  }
}
