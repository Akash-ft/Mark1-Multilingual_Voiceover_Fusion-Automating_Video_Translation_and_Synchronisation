import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../utils/reusable_widgets/alert_message.dart';
import '../../../utils/reusable_widgets/text_field.dart';
import '../../../utils/reusable_widgets/button.dart';
import 'controller.dart';

void handleStateChange(BuildContext context, WidgetRef ref) {
  ref.listen(
    loginStateProvider,
        (previous, next) {
      if (next.showAlert == true) {
        showMessageDialog(
          context: context,
          title: "Alert Message",
          message: next.alertMessage ?? "An error occurred.",
          onOkPressed: () {
            ref.read(loginStateProvider.notifier).resetAlert();
          },
        );
      }
    },
  );
}


Widget buildLoginTab(BuildContext context, WidgetRef ref) {
  handleStateChange(context,ref);
  final state = ref.watch(loginStateProvider);
  final controller = ref.read(loginStateProvider.notifier);
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          const SizedBox(height: 50,),
          buildCustomTextField(
            controller: state.emailController!,
            label: "Email",
            icon: Icons.mail_outline,
            isPassword: false,
          ),
          const SizedBox(height: 20),
          buildCustomTextField(
            controller: state.passwordController!,
            label: "Password",
            icon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: buildAuthButton(
              context,
              "Login",
              () => controller.onLoginPressed(context),
            ),
          ),
          const SizedBox(height: 20),
          // Switch to Register Text
          TextButton(
            onPressed: () => controller.switchTab(ref),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New here? ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Sign up into the app",
                  style: TextStyle(
                    color: Color(0xFF21D0B2),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
