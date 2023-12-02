import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../utils/router/named_router.dart';

final splashSProvider = Provider((ref) => SplashScreenController());

class SplashScreenController {
  Future<void> navigateToMainScreen(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    context.goNamed(RouteNames.homeScreen);
  }
}
