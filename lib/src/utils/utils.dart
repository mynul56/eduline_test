import 'package:flutter/material.dart';
import 'package:mynul_test/src/components/Text.dart';
import 'package:mynul_test/src/constants/Keys.dart';

class Utils {
  static SizedBox vertS(double height) {
    return SizedBox(height: height);
  }

  static SizedBox horiS(double width) {
    return SizedBox(width: width);
  }

  static String countryFromCode(String countryCode) {
    if (countryCode == "global") {
      return String.fromCharCode(0x1F310);
    } else {
      final upper = countryCode.toUpperCase();
      final codePoints = upper.codeUnits.map((char) => 0x1F1E6 + (char - 65));
      return String.fromCharCodes(codePoints);
    }
  }

  static snackBarErrorMessage(String message) {
    scaffoldMessengerKey.currentState!.removeCurrentSnackBar();
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.cancel_outlined, color: Colors.red),
            SizedBox(width: 10),
            AppText(message, fontColor: Colors.red),
          ],
        ),
        backgroundColor: Colors.blueGrey[200],
      ),
    );
  }

  static snackBarDefaultMessage(
    String message, {

    Color color = Colors.white,
    Color bgColor = Colors.black,
  }) {
    scaffoldMessengerKey.currentState!.removeCurrentSnackBar();
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: AppText(message, fontColor: color),
        backgroundColor: bgColor,
      ),
    );
  }
}
