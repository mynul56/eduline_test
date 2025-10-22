// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mynul_test/src/components/Button.dart';
import 'package:mynul_test/src/components/Text.dart';
import 'package:mynul_test/src/constants/Colors.dart';
import 'package:mynul_test/src/helpers/NavHelper.dart';
import 'package:mynul_test/src/models/LanguageModel.dart';
import 'package:mynul_test/src/utils/utils.dart';
import 'package:mynul_test/src/views/home/HomeScreen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<LanguageModel> _languages = [
    LanguageModel(name: "English (US)", code: "us", selected: true),
    LanguageModel(name: "Indonesia", code: "id", selected: false),
    LanguageModel(name: "Afghanistan", code: "af", selected: false),
    LanguageModel(name: "Algeria", code: "dz", selected: false),
    LanguageModel(name: "Malaysia", code: "my", selected: false),
    LanguageModel(name: "Arabic", code: "ae", selected: false),
  ];
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ActionButton(
          isLoading: false,
          btnText: 'Continue',
          btnTap: () {
            NavHelper.removeAllAndOpen(HomeScreen());
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'What is Your Mother Language',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                Utils.vertS(8),
                AppText(
                  'Discover what is a podcast description and podcast summary.',
                  fontSize: 16,
                  fontColor: AppColors.placeHolder,
                  textAlignment: TextAlign.start,
                  height: 1.5,
                ),

                Utils.vertS(30),

                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _languages.length,
                  separatorBuilder: (context, index) => Utils.vertS(12),
                  itemBuilder: (context, index) {
                    LanguageModel language = _languages[index];
                    return InkWell(
                      onTap: () {
                        for (var element in _languages) {
                          element.selected = false;
                        }
                        language.selected = true;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Text(
                                  Utils.countryFromCode(language.code),
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            Utils.horiS(12),
                            Expanded(
                              child: AppText(
                                language.name,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (language.selected)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.brandColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: AppText(
                                  'Selected',
                                  fontSize: 14,
                                  fontColor: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            else
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: AppText(
                                  'Select',
                                  fontSize: 14,
                                  fontColor: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
