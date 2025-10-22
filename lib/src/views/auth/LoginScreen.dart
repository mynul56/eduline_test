import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' hide Image;
import 'package:mynul_test/src/components/AnimatedDialogs.dart';
import 'package:mynul_test/src/components/Button.dart';
import 'package:mynul_test/src/components/Text.dart';
import 'package:mynul_test/src/components/TextField.dart';
import 'package:mynul_test/src/constants/Animations.dart';
import 'package:mynul_test/src/constants/Colors.dart';
import 'package:mynul_test/src/constants/Images.dart';
import 'package:mynul_test/src/helpers/NavHelper.dart';
import 'package:mynul_test/src/repository/shared_pref_repository.dart';
import 'package:mynul_test/src/repository/api/auth_repository.dart';
import 'package:mynul_test/src/utils/utils.dart';
import 'package:mynul_test/src/views/auth/SignupScreen.dart';
import 'package:mynul_test/src/views/auth/forgot/ForgotPassword.dart';
import 'package:mynul_test/src/views/home/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.isFirstTime = false});

  final bool isFirstTime;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  final _authRepository = AuthRepository();

  _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    TextInput.finishAutofillContext();

    try {
      final success = await _authRepository.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (success) {
        if (mounted) setState(() => _isLoading = false);
        _showSuccess();
      } else {
        if (mounted) setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Invalid email or password')));
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
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
            AppText('Welcome Back!', fontSize: 28, fontWeight: FontWeight.bold),
            Utils.vertS(10),
            AppText(
              "Successfully logged in. Let's explore our features!",
              fontSize: 16,
              fontColor: AppColors.placeHolder,
              textAlignment: TextAlign.center,
            ),
            Utils.vertS(25),
            ActionButton(
              isLoading: false,
              btnText: 'Continue',
              btnTap: () {
                NavHelper.removeAllAndOpen(HomeScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _buildLoginForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Image.asset(AppImages.logo, fit: BoxFit.contain),
          ),
          Utils.vertS(20),
          AppText('Welcome Back!', fontSize: 28, fontWeight: FontWeight.bold),
          Utils.vertS(10),
          AppText(
            'Please login first to start your Theory Test.',
            fontSize: 16,
            fontColor: AppColors.placeHolder,
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
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                ),
                Utils.vertS(20),
                AppTextField(
                  label: "Password",
                  hintText: "e.g. 123456789",
                  controller: _passwordController,
                  isPassword: _isPasswordVisible,
                  autofillHints: const [AutofillHints.password],
                  visibility: true,
                  onSuffixTap: () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  },
                ),
              ],
            ),
          ),

          Utils.vertS(16),
          _buildRememberForgotRow(),
          Utils.vertS(30),
          ActionButton(
            isLoading: _isLoading,
            btnText: 'Login',
            btnTap: () => _login(),
          ),

          _buildSignupPrompt(),
        ],
      ),
    );
  }

  Widget _buildRememberForgotRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) =>
                  setState(() => _rememberMe = value ?? false),
              checkColor: AppColors.creamWhite,
              activeColor: AppColors.brandColor,
            ),
            const SizedBox(width: 8),
            AppText('Remember me'),
          ],
        ),
        TextButton(
          onPressed: () => NavHelper.addWithAnimation(ForgotPassword()),
          child: AppText('Forgot Password?'),
        ),
      ],
    );
  }

  Widget _buildSignupPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText('Don\'t have an account? '),
        TextButton(
          onPressed: () {
            NavHelper.addWithAnimation(SignupScreen());
          },
          child: AppText(
            'Sign Up',
            fontColor: AppColors.brandColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
