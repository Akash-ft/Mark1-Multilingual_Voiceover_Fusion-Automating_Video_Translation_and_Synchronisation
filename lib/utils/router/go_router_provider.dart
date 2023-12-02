import 'package:b_native/utils/router/named_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../screens/home_screen/view.dart';
import '../../screens/splash_screen/view.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(routes: [
    GoRoute(
      path: '/',
      name: RouteNames.splashScreen,
      builder: (context, state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: '/HomeScreen',
      name: RouteNames.homeScreen,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
            key: state.pageKey,
            child: HomeScreen(),
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (context, animation, secondaryAnimation,
                    child) =>
                // FadeTransition(
                //     opacity:
                //         CurveTween(curve: Curves.fastEaseInToSlowEaseOut).animate(animation),
                //     child: child));
                SlideTransition(
                  child: child,
                  position: animation.drive(
                      Tween(begin: Offset(0.0, 1.0), end: Offset.zero)
                          .chain(CurveTween(curve: Curves.ease))),
                ));
      },
    ),
  ]);
});
