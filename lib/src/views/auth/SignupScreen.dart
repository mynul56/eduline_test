import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:mynul_test/src/components/AnimatedDialogs.dart';
import 'package:mynul_test/src/components/Button.dart';
import 'package:mynul_test/src/components/Text.dart';
import 'package:mynul_test/src/components/TextField.dart';
import 'package:mynul_test/src/constants/Animations.dart';
import 'package:mynul_test/src/constants/Colors.dart';
import 'package:mynul_test/src/constants/Regex.dart';
import 'package:mynul_test/src/helpers/NavHelper.dart';
import 'package:mynul_test/src/utils/utils.dart';
import 'package:mynul_test/src/views/auth/LoginScreen.dart';
import 'package:mynul_test/src/views/permission/PermissionScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  _signup() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    await Future.delayed(Duration(seconds: 2));
    setState(() => _isLoading = false);
    _showSuccess();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  _showSuccess() async {
    await AnimatedDialogs.showTransitionDialog(
      dismissible: false,
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 200,
                width: 300,
                child: RiveAnimation.asset(
                  AppAnims.successSignup,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Utils.vertS(20),

            AppText(
              'Successfully Registered',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            Utils.vertS(10),
            AppText(
              'Your account has been registered successfully, now let’s enjoy our features!',
              fontSize: 16,
              fontColor: AppColors.placeHolder,
            ),
            Utils.vertS(25),
            ActionButton(
              isLoading: _isLoading,
              btnText: 'Continue',
              btnTap: () => NavHelper.removeAllAndOpen(PermissionScreen()),
            ),
          ],
        ),
      ),
    );
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
            child: _buildSignupForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Utils.vertS(20),
          Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              'Welcome to Eduline',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Utils.vertS(10),
          Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              'Let’s join to Eduline learning ecosystem & meet our professional mentor. It’s Free!',
              fontSize: 16,
              fontColor: AppColors.placeHolder,
              textAlignment: TextAlign.start,
            ),
          ),
          Utils.vertS(40),
          AutofillGroup(
            child: Column(
              children: [
                AppTextField(
                  controller: _emailController,
                  label: "Email Address",
                  isPassword: false,
                  hintText: "e.g. mynulislamtanim@gmail.com",
                  autofillHints: const [AutofillHints.email],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!emailRegex.hasMatch(value)) {
                      return 'Please type your email correctly';
                    }
                    return null;
                  },
                ),
                Utils.vertS(20),
                AppTextField(
                  controller: _nameController,
                  label: "Full Name",
                  isPassword: false,
                  hintText: "e.g. Mynul Islam",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                Utils.vertS(20),
                AppTextField(
                  label: "Password",
                  hintText: "e.g. 123456789",
                  controller: _passwordController,
                  isPassword: _isPasswordVisible,
                  autofillHints: const [AutofillHints.password],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  visibility: true,
                  onSuffixTap: () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  },
                ),

                Utils.vertS(20),
                ValueListenableBuilder(
                  valueListenable: _passwordController,
                  builder: (context, value, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        passwordRegex.hasMatch(value.text.trim())
                            ? Icon(
                                Icons.check_circle_outline_rounded,
                                color: Colors.green,
                              )
                            : Icon(Icons.remove_circle_outline_rounded),
                        Utils.horiS(8),
                        Flexible(
                          child: AppText(
                            "At least 8 characters with a combination of letters and numbers",
                            fontColor: passwordRegex.hasMatch(value.text.trim())
                                ? Colors.green
                                : AppColors.semiDark,
                            textAlignment: TextAlign.start,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          Utils.vertS(30),
          ActionButton(
            isLoading: _isLoading,
            btnText: 'SIGN UP',
            btnTap: () => _signup(),
          ),

          _buildLoginPrompt(),
        ],
      ),
    );
  }

  Widget _buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText('Already have an account? '),
        TextButton(
          onPressed: () {
            NavHelper.removeAllAndOpen(LoginScreen());
          },
          child: AppText(
            'Login',
            fontColor: AppColors.brandColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
