import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynul_test/src/components/Text.dart';
import 'package:mynul_test/src/constants/Colors.dart';
import 'package:mynul_test/src/utils/utils.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.isPassword,
    required this.label,
    this.autofillHints,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.hintText,
    this.onSuffixTap,
    this.visibility = false,
  });

  final TextEditingController controller;
  final bool isPassword;
  final bool visibility;
  final String label;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final String? hintText;
  final VoidCallback? onSuffixTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, fontSize: 16, fontWeight: FontWeight.w700),
        Utils.vertS(10),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: const TextStyle(color: AppColors.semiDark),
          autofillHints: autofillHints,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700]),
            suffixIcon: visibility
                ? IconButton(
                    icon: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[700],
                    ),
                    onPressed: onSuffixTap,
                  )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
