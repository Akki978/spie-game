import 'package:flutter/material.dart';
import 'package:mole/common/common_strings.dart';
import 'package:mole/size/size_config.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.h(40)),
            Image.asset('assets/spy2.png', height: SizeConfig.h(200)),
            SizedBox(height: SizeConfig.h(30)),
            SizedBox(
              height: SizeConfig.h(230),
              child: PageView.builder(
                controller: controller,
                itemCount: tutorialTexts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(24)),
                    child: Center(
                      child: Text(
                        tutorialTexts[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: SizeConfig.w(18),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: SizeConfig.h(30)),
            SmoothPageIndicator(
              controller: controller,
              count: tutorialTexts.length,
              effect: WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: Colors.purpleAccent,
                dotColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
