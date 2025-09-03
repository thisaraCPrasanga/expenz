import 'package:expenzapp/constants/colors.dart';
import 'package:expenzapp/constants/widgets/custom_button.dart';
import 'package:expenzapp/data/onboarding_data.dart';
import 'package:expenzapp/screens/onboarding/front_page.dart';
import 'package:expenzapp/screens/onboarding/shared_onboarding_screen.dart';
import 'package:expenzapp/screens/user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool showDetailsPage = false;
  //page controller
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                //onboarding screens
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailsPage = index == 3;
                    });
                  },
                  children: [
                    FrontPage(),
                    SharedOnboardingScreen(
                      imagePath: OnboardingData.onboardingDataList[0].imagePath,
                      title: OnboardingData.onboardingDataList[0].title,
                      description:
                          OnboardingData.onboardingDataList[0].description,
                    ),
                    SharedOnboardingScreen(
                      imagePath: OnboardingData.onboardingDataList[1].imagePath,
                      title: OnboardingData.onboardingDataList[1].title,
                      description:
                          OnboardingData.onboardingDataList[1].description,
                    ),
                    SharedOnboardingScreen(
                      imagePath: OnboardingData.onboardingDataList[2].imagePath,
                      title: OnboardingData.onboardingDataList[2].title,
                      description:
                          OnboardingData.onboardingDataList[2].description,
                    ),
                  ],
                ),

                //page indicators
                Container(
                  alignment: Alignment(0, 0.65),
                  child: SmoothPageIndicator(
                    controller: _controller,

                    count: 4,
                    effect: WormEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey,
                    ),
                  ),
                ),

                //navigation button
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child:
                        !showDetailsPage
                            ? GestureDetector(
                              onTap: () {
                                _controller.animateToPage(
                                  _controller.page!.toInt() + 1,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: CustomButton(
                                buttonName:
                                    showDetailsPage ? "Get Started" : "Next",
                                buttonColor: kMainColor,
                              ),
                            )
                            : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserDataScreen(),
                                  ),
                                );
                              },
                              child: CustomButton(
                                buttonName:
                                    showDetailsPage ? "Get Started" : "Next",
                                buttonColor: kMainColor,
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
