import 'package:flutter/material.dart';
import 'package:mynul_test/src/components/Button.dart';
import 'package:mynul_test/src/components/Text.dart';
import 'package:mynul_test/src/components/TextField.dart';
import 'package:mynul_test/src/constants/Colors.dart';
import 'package:mynul_test/src/constants/Images.dart';
import 'package:mynul_test/src/helpers/NavHelper.dart';
import 'package:mynul_test/src/utils/utils.dart';
import 'package:mynul_test/src/views/auth/forgot/OtpScreen.dart';
import 'package:mynul_test/src/constants/Regex.dart';
import 'package:mynul_test/src/repository/api/auth_repository.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  final _authRepo = AuthRepository();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final email = _emailController.text.trim();
      final success = await _authRepo.sendResetEmail(email);
      setState(() => _isLoading = false);
      if (success) {
        Utils.snackBarDefaultMessage('Verification code sent to $email');
        NavHelper.addWithAnimation(OtpScreen(email: email));
      } else {
        Utils.snackBarDefaultMessage('Failed to send verification. Try again.');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      // fallback to simulated success if network not configured
      Utils.snackBarDefaultMessage(
        'Network error or not configured — using demo flow',
      );
      NavHelper.addWithAnimation(
        OtpScreen(email: _emailController.text.trim()),
      );
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
            child: _buildEmailForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Utils.vertS(20),
          AppText('Forgot Password', fontSize: 28, fontWeight: FontWeight.bold),
          Utils.vertS(10),
          AppText(
            'Enter your email, we will send a verification code to email',
            fontSize: 16,
            fontColor: AppColors.placeHolder,
            textAlignment: TextAlign.center,
          ),
          Utils.vertS(40),
          AppTextField(
            controller: _emailController,
            label: "Email Address",
            isPassword: false,
            hintText: "e.g. mynulislamtanim@gmail.com",
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!emailRegex.hasMatch(value.trim())) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          Utils.vertS(30),
          ActionButton(
            isLoading: _isLoading,
            btnText: 'Continue',
            btnTap: () => _sendEmail(),
          ),
        ],
      ),
    );
  }
}
