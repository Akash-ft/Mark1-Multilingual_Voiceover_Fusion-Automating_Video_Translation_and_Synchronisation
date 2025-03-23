import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../utils/router/named_router.dart';
import '../controller.dart';
import 'state.dart';

final loginStateProvider =
    StateNotifierProvider.autoDispose<LoginWidgetController, LoginWidgetState>(
  (ref) => LoginWidgetController(),
);

class LoginWidgetController extends StateNotifier<LoginWidgetState> {
  LoginWidgetController() : super(LoginWidgetState.empty());

  final supabase = Supabase.instance.client;

  Future<void> onLoginPressed(BuildContext context) async {
    final email = state.emailController?.text.trim() ?? "";
    final password = state.passwordController?.text.trim() ?? "";
    if (state.emailController!.text.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,}$")
            .hasMatch(state.emailController!.text)) {
      state = state.copyWith(
          showAlert: true, alertMessage: "Enter a valid email address");
      return;
    }
    if (state.passwordController!.text.isEmpty) {
      state = state.copyWith(
          showAlert: true, alertMessage: "Please enter your password");
      return;
    }
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      context.goNamed(RouteNames.homeScreen);
    } catch (e) {
      state = state.copyWith(showAlert: true, alertMessage: e.toString());
    }
  }

  void resetAlert() {
    state = state.copyWith(showAlert: false, alertMessage: null);
  }

  void clearFields() {
    state.emailController?.clear();
    state.passwordController?.clear();
  }

  void switchTab(WidgetRef ref) {
    ref.read(tabIndexProvider.notifier).state = 1;
  }
}
