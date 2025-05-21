import 'package:e_commerce/features/intro/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../base/ResponsiveLayout.dart';
import '../../base/size_config.dart';
import '../../base/theme.dart';
import '../login/Login Screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final controller = OnboardingItems();
  final pagecontroller = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pagecontroller.addListener(() {
      setState(() {
        currentIndex = pagecontroller.page?.round() ?? 0;
      });
    });
  }
  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return ResponsiveLayout(
      mobile: _buildOnboarding(context),
      tablet: _buildOnboarding(context, scaleFactor: 1.2),
      desktop: _buildOnboarding(context, scaleFactor: 1.5),
    );
  }

  Widget _buildOnboarding(BuildContext context, {double scaleFactor = 1.0}) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.h(15 * scaleFactor)),
        child: PageView.builder(
          controller: pagecontroller,
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/Logo/LOGO.png",
                  height: SizeConfig.h(160 * scaleFactor),
                  width: SizeConfig.w(180 * scaleFactor),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(controller.items[index].image),
                    SizedBox(height: SizeConfig.h(5 * scaleFactor)),
                    Text(
                      controller.items[index].tittle,
                      style: TextStyle(
                        fontSize: 18 * scaleFactor,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      controller.items[index].description,
                      style: TextStyle(
                        fontSize: 16 * scaleFactor,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.h(15 * scaleFactor),
          vertical: SizeConfig.w(12 * scaleFactor),
        ),
        height: SizeConfig.h(60 * scaleFactor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                pagecontroller.jumpToPage(controller.items.length - 1);
              },
              child: const Text('Skip'),
            ),
            SmoothPageIndicator(
              controller: pagecontroller,
              count: controller.items.length,
              effect: const WormEffect(activeDotColor: AppColors.primary),
            ),
            TextButton(
              onPressed: () {
                if (currentIndex == controller.items.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                } else {
                  pagecontroller.nextPage(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: Text(currentIndex == controller.items.length - 1 ? 'Done' : 'Next'),
            ),
          ],
        ),
      ),
    );
  }
}
