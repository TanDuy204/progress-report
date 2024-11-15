//CLASS CHA: QUẢN LÝ CÁC PAGE CON. DI CHUYỂN QUA LẠI GIỮA CACS PAGE CON

import 'package:flutter/material.dart';

import '../../untils.enums/onboanding_page_position.dart';
import 'onboarding_child_page.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: PageView(
            children: const [
              //truyền vao các widget mà muốn pageview hiển thị
              OnboardingChildPage(
                onboardingPagePosition: Onboarding_page_position.page1,
              ),
              OnboardingChildPage(
                onboardingPagePosition: Onboarding_page_position.page2,
              ),
              OnboardingChildPage(
                onboardingPagePosition: Onboarding_page_position.page3,
              ),
            ],
          ),
        ),
        _buildOnboardingLoginAndRegister()
      ]),
    );
  }

  Widget _buildOnboardingLoginAndRegister() {
    return Container(
      color: Colors.grey,
      height: 247,
      margin: EdgeInsets.only(top: 70),
      child: Container(
        margin: EdgeInsets.only(top: 30),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Đăng nhập bằng Google"),
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Đăng nhập bằng Apple"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
