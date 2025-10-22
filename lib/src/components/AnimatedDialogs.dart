import 'package:flutter/material.dart';
import 'package:mynul_test/src/helpers/NavHelper.dart';

class AnimatedDialogs {
  static Future<void> showTransitionDialog(
    Widget dialogChild, {
    String label = "default",
    Color backgroundColor = Colors.white,
    int duration = 300,
    bool dismissible = true,
  }) {
    return showGeneralDialog(
      barrierDismissible: dismissible,
      barrierLabel: label,
      context: NavHelper.navigatorKey.currentState!.context,

      pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          child: Center(
            child: Dialog(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight * 0.5,
                    ),
                    child: dialogChild,
                  );
                },
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: duration),
    );
  }
}
