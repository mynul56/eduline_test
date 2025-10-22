import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:mynul_test/src/components/Button.dart';
import 'package:mynul_test/src/components/Text.dart';
import 'package:mynul_test/src/constants/Animations.dart';
import 'package:mynul_test/src/constants/Colors.dart';
import 'package:mynul_test/src/helpers/NavHelper.dart';
import 'package:mynul_test/src/repository/shared_pref_repository.dart';
import 'package:mynul_test/src/utils/utils.dart';
import 'package:mynul_test/src/views/auth/LoginScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Best online courses in the world",
      "subtitle":
          "Now you can learn anywhere, anytime, even if there is no internet access!",
      "image": AppAnims.onboarding1,
      "btnText": "Next",
    },
    {
      "title": "Explore your new skill today",
      "subtitle":
          "Our platform is designed to help you explore new skills. Let’s learn & grow with Eduline!",
      "image": AppAnims.onboarding2,
      "btnText": "Get Started",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingData.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (_, index) => _buildPage(_onboardingData[index]),
            physics: NeverScrollableScrollPhysics(),
          ),
          Positioned(
            bottom: 125,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(_onboardingData.length, (index) {
                final isActive = index == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: isActive ? 24 : 8,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.brandColor
                        : AppColors.brandColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildPage(Map<String, dynamic> data) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(flex: 1),

          Center(
            child: SizedBox(
              height: 200,
              width: 300,
              child: RiveAnimation.asset(
                data['image'],
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Spacer(flex: 1),

          AppText(
            data['title'],
            fontSize: 28,
            maxLines: 2,
            fontWeight: FontWeight.bold,
          ),
          Utils.vertS(30),
          AppText(
            data['subtitle'],
            maxLines: 2,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          Spacer(flex: 2),
          ActionButton(
            isLoading: false,
            btnText: data['btnText'],
            btnTap: () async {
              if (_currentPage >= _onboardingData.length - 1) {
                await SharedPrefRepository.saveFirstTime();
                NavHelper.removeAllAndOpen(LoginScreen());
              } else {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
