import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Animate the fade-in effect
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Navigate to Auth Screen after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      ref.read(splashSProvider).navigateToAuthScreen(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F455C),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          opacity: _opacity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hero Animation for Logo
              Hero(
                tag: "appLogo",
                child: Image.asset(
                  'asset/icons/app_icon.png',
                  width: 120,
                  height: 120,
                ),
              ),
              const SizedBox(height: 20),
              // Hero Animation for App Name
              const Hero(
                tag: "appName",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "VVF",
                    style: TextStyle(
                      fontSize: 36,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // App Description with Fade Animation
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeInOut,
                opacity: _opacity,
                child: const Text(
                  "Video Voiceover Fusion",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
