import 'package:flutter/material.dart';

Widget buildCustomTextField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  bool isPassword = false,
}) {
  // Managing password visibility internally
  ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: ValueListenableBuilder(
      valueListenable: isPasswordVisible,
      builder: (context, value, child) {
        return TextField(
          controller: controller,
          obscureText: isPassword ? !value : false,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white),
            prefixIcon: Icon(icon, color: Colors.white),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                value ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
              onPressed: () {
                isPasswordVisible.value = !isPasswordVisible.value;
              },
            )
                : null,
            filled: true,
            fillColor: const Color(0xFF1E2A38),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF21D0B2)),
            ),
          ),
        );
      },
    ),
  );
}
