import 'package:flutter/material.dart';
import 'package:mynul_test/src/components/Text.dart';
import 'package:mynul_test/src/constants/Colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.isLoading,
    required this.btnText,
    this.btnTap,
  });
  final bool isLoading;
  final String btnText;
  final VoidCallback? btnTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: isLoading ? null : () => btnTap?.call(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.brandColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 2,
            shadowColor: AppColors.semiDark,
          ),
          child: isLoading
              ? const CircularProgressIndicator(color: AppColors.creamWhite)
              : AppText(
                  btnText,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontColor: AppColors.creamWhite,
                ),
        ),
      ),
    );
  }
}
