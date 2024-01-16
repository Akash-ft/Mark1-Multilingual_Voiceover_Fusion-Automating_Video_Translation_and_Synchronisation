import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(splashSProvider).navigateToMainScreen(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/icons/app_icon.png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 20),
                const Text(
                  "MVF",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                const Text(
                  "Multilingual Voiceover Fusion",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 16),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Developed by",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "AKASH R",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
