import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class AdminTextField extends StatelessWidget {
  const AdminTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.onTap,
    this.hint,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
  });

  final Function()? onTap;
  final String labelText;
  final String? hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final IconData? suffixIcon;
  final bool obscureText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onTap: onTap,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(suffixIcon, color: Colors.grey),
        floatingLabelStyle: const TextStyle(
          color: AppColors.customRed,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Color(0xFFD92728),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
