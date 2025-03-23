import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MVF/screens/auth_screen/registration_widget/controller.dart';
import '../../../utils/reusable_widgets/alert_message.dart';
import '../../../utils/reusable_widgets/button.dart';
import '../../../utils/reusable_widgets/text_field.dart';


void handleStateChange(BuildContext context, WidgetRef ref) {
  ref.listen(
    registrationStateProvider,
        (previous, next) {
      if (next.showAlert == true) {
        showMessageDialog(
          context: context,
          title: "Alert Message",
          message: next.alertMessage ?? "An error occurred.",
          onOkPressed: () {
            ref.read(registrationStateProvider.notifier).resetAlert();
          },
        );
      }
    },
  );
}
Widget buildRegistrationTab(BuildContext context, WidgetRef ref) {
  handleStateChange(context,ref);
  final state = ref.watch(registrationStateProvider);
  final controller = ref.read(registrationStateProvider.notifier);
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          const SizedBox(height: 20),
          buildCustomTextField(
            controller: state.nameController!,
            label: "Name",
            icon: Icons.person,
          ),
          const SizedBox(height: 20),

          buildCustomTextField(
            controller: state.emailController!,
            label: "Email",
            icon: Icons.email,
          ),
          const SizedBox(height: 20),
          buildCustomTextField(
            controller: state.passwordController!,
            label: "Password",
            icon: Icons.lock,
            isPassword: true,
          ),
          const SizedBox(height: 20),
          buildCustomTextField(
            controller: state.confirmPasswordController!,
            label: "Confirm Password",
            icon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 30),

          // Register Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: buildAuthButton(
              context,
              "Register",
                  () => controller.onRegisterPressed(ref),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
