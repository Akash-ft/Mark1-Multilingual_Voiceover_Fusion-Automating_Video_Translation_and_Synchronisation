import 'package:flutter/material.dart';

class LoginWidgetState {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final bool? showAlert;
  final String? alertMessage;
  final int? onSwitchScreen;

  LoginWidgetState({
    this.emailController,
     this.passwordController,
    this.showAlert,
    this.alertMessage,
    this.onSwitchScreen,
  });

  factory LoginWidgetState.empty() {
    return LoginWidgetState(
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      alertMessage: "",
      showAlert:false,
      onSwitchScreen: 0,
    );
  }

  LoginWidgetState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    String? alertMessage,
    bool? showAlert,
    int? onSwitchScreen,
  }) {
    return LoginWidgetState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      onSwitchScreen: onSwitchScreen ?? this.onSwitchScreen,
      showAlert: showAlert ?? this.showAlert,
        alertMessage:alertMessage ?? this.alertMessage,
    );
  }
}
