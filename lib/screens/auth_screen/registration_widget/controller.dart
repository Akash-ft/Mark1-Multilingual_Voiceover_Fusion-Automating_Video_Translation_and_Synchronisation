
import "package:flutter_riverpod/flutter_riverpod.dart" show StateNotifier, StateNotifierProvider, WidgetRef;
import 'package:MVF/screens/auth_screen/registration_widget/state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controller.dart';


final registrationStateProvider = StateNotifierProvider<
    RegistrationWidgetController, RegistrationWidgetState>(
  (ref) => RegistrationWidgetController(),
);

class RegistrationWidgetController
    extends StateNotifier<RegistrationWidgetState> {
  RegistrationWidgetController() : super(RegistrationWidgetState.empty());

  final supabase = Supabase.instance.client;

  void clearFields() {
    state.nameController?.clear();
    state.emailController?.clear();
    state.passwordController?.clear();
    state.confirmPasswordController?.clear();
  }

  Future<void> onRegisterPressed(WidgetRef ref) async {
    final email = state.emailController?.text.trim()??"";
    final password = state.passwordController?.text.trim()??"";
    validateAndRegister();
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      state = state.copyWith(showAlert: true, alertMessage: "Success");
    }
    catch(e)
    {
      state = state.copyWith(showAlert: true, alertMessage: e.toString());
    }
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

    });
      return;
    }

   validateAndRegister() {
    if (state.nameController!.text.isEmpty) {
      state = state.copyWith(
          showAlert: true, alertMessage: "Please enter your name");
      return;
    }
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
    if (state.passwordController!.text != state.confirmPasswordController!.text) {
      state = state.copyWith(
          showAlert: true, alertMessage: "Passwords do not match");
      return;
    }
    return null; // No errors
  }
  void resetAlert() {
    state = state.copyWith(showAlert: false, alertMessage: null);
  }

  void switchTab(WidgetRef ref) {
    ref.read(tabIndexProvider.notifier).state = 0;
  }
}
