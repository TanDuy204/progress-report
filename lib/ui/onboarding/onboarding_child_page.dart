import 'package:flutter/material.dart';

import '../../untils.enums/onboanding_page_position.dart';

/// ĐÓNG VAI TRÒ LÀ GIAO DIỆN MÀN HÌNH
class OnboardingChildPage extends StatelessWidget {
  final Onboarding_page_position onboardingPagePosition;

  const OnboardingChildPage({super.key, required this.onboardingPagePosition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildOnboardingImage(),
            _buildOnboardingTitleAndContent(),
            _buildOnboardingPageControl(),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingImage() {
    return Image.asset(
      onboardingPagePosition.onboardingImage(),
      height: 296,
      width: 271,
      fit: BoxFit.contain,
    );
  }

  Widget _buildOnboardingTitleAndContent() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            onboardingPagePosition.onboardingTitle(),
            style: TextStyle(
                fontSize: 32, fontFamily: "lato", fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 35),
            child: Text(
              onboardingPagePosition.onboardingContent(),
              style: TextStyle(
                fontSize: 16,
                fontFamily: "lato",
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPageControl() {
    return Container(
      margin: EdgeInsets.only(
        top: 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }
}
