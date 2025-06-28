import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/constants/color.dart';
import 'package:travelapp/features/onboarding/presentation/pages/onboarding_page.dart';

/// Splash screen displayed when the app starts
class SplashPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/splash';

  /// Creates a new [SplashPage] instance
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  bool play = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  height: 150.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/splash.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              Center(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 250.0,
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.headlineLarge!,
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
                                builder: (context) => const OnboardingPage()),
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
    );
  }

  void goToMainScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const OnboardingPage();
    }));
  }
}
