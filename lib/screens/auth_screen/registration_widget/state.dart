import 'package:flutter/material.dart';

class RegistrationWidgetState {
  final TextEditingController? emailController;
  final TextEditingController? nameController;
  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;
  final bool? showAlert;
  final String? alertMessage;
  final int? onSwitchScreen;

  RegistrationWidgetState({
   this.emailController,
    this.nameController,
     this.passwordController,
    this.confirmPasswordController,
     this.onSwitchScreen,
    this.alertMessage,
    this.showAlert
  });

  factory RegistrationWidgetState.empty() {
    return RegistrationWidgetState(
      nameController: TextEditingController(),
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      confirmPasswordController: TextEditingController(),
      alertMessage:"",
       showAlert: false,
      onSwitchScreen: 0,
    );
  }

  RegistrationWidgetState copyWith({
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    bool? showAlert,
    int? onSwitchScreen,
    String? alertMessage,
  }) {
    return RegistrationWidgetState(
      nameController:nameController ??this.nameController,
      confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      onSwitchScreen: onSwitchScreen ?? this.onSwitchScreen,
      showAlert: showAlert ?? this.showAlert,
      alertMessage: alertMessage ?? this.alertMessage
    );
  }
}
