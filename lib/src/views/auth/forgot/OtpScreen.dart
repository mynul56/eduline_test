import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynul_test/src/components/Text.dart';
import 'package:mynul_test/src/constants/Colors.dart';
import 'package:mynul_test/src/helpers/NavHelper.dart';
import 'package:mynul_test/src/utils/utils.dart';
import 'package:mynul_test/src/views/auth/forgot/ResetPassword.dart';
import 'package:mynul_test/src/repository/api/auth_repository.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _authRepo = AuthRepository();

  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  int _resendSeconds = 60;
  Timer? _resendTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startResendTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNodes[0].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    _resendTimer?.cancel();
    super.dispose();
  }

  Future<void> _resendOTP() async {
    if (_resendSeconds > 0) return;

    setState(() => _isLoading = true);
    try {
      final success = await _authRepo.sendResetEmail(widget.email);
      setState(() => _isLoading = false);
      if (success) {
        Utils.snackBarDefaultMessage("Verification code sent successfully");
        for (final controller in _controllers) {
          controller.clear();
        }
        _startResendTimer();
      } else {
        Utils.snackBarDefaultMessage("Failed to send code. Please try again.");
      }
    } catch (e) {
      setState(() => _isLoading = false);
      Utils.snackBarDefaultMessage("Network error. Using demo flow.");
      _startResendTimer();
    }
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    _resendSeconds = 60;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() {
          _resendSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _verifyOTP() async {
    // Check if we have all 4 digits
    final code = _controllers.map((c) => c.text).join();
    if (code.length != 4) {
      Utils.snackBarDefaultMessage('Please enter all 4 digits');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await _authRepo.verifyOtp(widget.email, code);
      if (success) {
        Utils.snackBarDefaultMessage('Code verified successfully');
        NavHelper.addWithAnimation(ResetPassword(email: widget.email));
      } else {
        setState(() => _isLoading = false);
        Utils.snackBarDefaultMessage('Invalid code. Please try again');
        for (final controller in _controllers) {
          controller.clear();
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      Utils.snackBarDefaultMessage('Network error. Using demo flow');
      // In demo mode, any 4-digit code works
      NavHelper.addWithAnimation(ResetPassword(email: widget.email));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 45,

        leading: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            NavHelper.remove();
          },
          child: Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.placeHolder, width: 2),
            ),
            child: Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _buildOTPForm(),
          ),
        ),
      ),
    );
  }

  String _maskEmail(String email) {
    if (email.isEmpty) return '';
    var parts = email.split('@');
    if (parts.length != 2) return email;
    var username = parts[0];
    if (username.length <= 3) return email;
    return '${username.substring(0, 3)}...@${parts[1]}';
  }

  Widget _buildOTPForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Utils.vertS(20),
          AppText('Verify Code', fontSize: 28, fontWeight: FontWeight.bold),
          Utils.vertS(10),
          AppText(
            'Please enter the code sent to email',
            fontSize: 16,
            fontColor: AppColors.placeHolder,
          ),
          Utils.vertS(4),
          AppText(
            _maskEmail(widget.email),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          Utils.vertS(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) => _buildOTPField(index)),
          ),
          Utils.vertS(16),
          TextButton(
            onPressed: _resendSeconds > 0 ? null : _resendOTP,
            child: AppText(
              _resendSeconds > 0
                  ? 'Resend code in ${(_resendSeconds ~/ 60).toString().padLeft(2, '0')}:${(_resendSeconds % 60).toString().padLeft(2, '0')}'
                  : 'Resend code',
              fontSize: 14,
              fontColor: _resendSeconds > 0
                  ? AppColors.placeHolder
                  : AppColors.brandColor,
            ),
          ),
          Utils.vertS(40),
          if (_isLoading)
            CircularProgressIndicator(color: AppColors.brandColor)
          else
            _buildNumericKeypad(),
        ],
      ),
    );
  }

  void _handleInput(String value) {
    for (int i = 0; i < 4; i++) {
      if (_controllers[i].text.isEmpty) {
        _controllers[i].text = value;
        if (i < 3) {
          _focusNodes[i + 1].requestFocus();
        } else {
          _verifyOTP();
        }
        break;
      }
    }
  }

  void _handleBackspace() {
    for (int i = 3; i >= 0; i--) {
      if (_controllers[i].text.isNotEmpty) {
        _controllers[i].clear();
        if (i > 0) {
          _focusNodes[i - 1].requestFocus();
        }
        break;
      }
    }
  }

  Widget _buildNumericKeypad() {
    return Column(
      children:
          [
                [1, 2, 3],
                [4, 5, 6],
                [7, 8, 9],
                [null, 0, -1],
              ]
              .map(
                (row) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: row.map((num) {
                    if (num == null) {
                      return SizedBox(width: 80, height: 80);
                    }
                    if (num == -1) {
                      return InkWell(
                        onTap: _handleBackspace,
                        child: Container(
                          width: 80,
                          height: 80,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.backspace_outlined,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () => _handleInput(num.toString()),
                      child: Container(
                        width: 80,
                        height: 80,
                        alignment: Alignment.center,
                        child: Text(
                          num.toString(),
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
              .toList(),
    );
  }

  Widget _buildOTPField(int index) {
    return Container(
      width: 60,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _controllers[index].text.isNotEmpty
              ? AppColors.brandColor
              : Colors.white.withOpacity(0.3),
          width: _controllers[index].text.isNotEmpty ? 2 : 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        _controllers[index].text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
