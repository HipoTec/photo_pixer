import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:test_app/screen/onboarding.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          SizedBox(
            width: 300,
            height: 150,
            child: Image.asset(
              "assets/logo.png",
              width: 200,
              height: 250,
            ),
          ),
          const SizedBox(height: 16),
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('Photo Pixer'),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      nextScreen: OnBoardingPage(),
      splashIconSize: 250,
      duration: 2300,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
