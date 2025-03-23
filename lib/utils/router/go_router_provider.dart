import 'package:MVF/utils/router/named_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../screens/home_screen/view.dart';
import '../../screens/splash_screen/view.dart';
import '../../screens/auth_screen/view.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.splashScreen,
        pageBuilder: (context, state) {
          return _buildSlideTransition(
            state,
            const SplashScreen(),
          );
        },
      ),
      GoRoute(
        path: '/HomeScreen',
        name: RouteNames.homeScreen,
        pageBuilder: (context, state) {
          return _buildSlideTransition(
            state,
            const HomeScreen(),
          );
        },
      ),
      GoRoute(
        path: '/AuthScreen',
        name: RouteNames.authScreen,
        pageBuilder: (context, state) {
          return _buildSlideTransition(
            state,
            const AuthScreen(),
          );
        },
      ),
    ],
  );
});


CustomTransitionPage _buildSlideTransition(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(1.0, 0.0), // Slide from right to left
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: child,
      );
    },
  );
}
