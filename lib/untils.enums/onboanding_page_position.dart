enum Onboarding_page_position {
  page1,
  page2,
  page3,
}

extension Onboarding_page_positionExtension on Onboarding_page_position {
  String onboardingImage() {
    switch (this) {
      case Onboarding_page_position.page1:
        return "assets/images/onboarding_1.png";
      case Onboarding_page_position.page2:
        return "assets/images/onboarding_2.png";
      case Onboarding_page_position.page3:
        return "assets/images/onboarding_3.png";
    }
  }

  String onboardingTitle() {
    switch (this) {
      case Onboarding_page_position.page1:
        return "Quản lý nhiệm vụ của bạn";
      case Onboarding_page_position.page2:
        return "Tạo thói quen hàng ngày";
      case Onboarding_page_position.page3:
        return "Tổ chức nhiệm vụ của bạn";
    }
  }

  String onboardingContent() {
    switch (this) {
      case Onboarding_page_position.page1:
        return "Bạn có thể dễ dàng quản lý tất cả các công việc hàng ngày của mình trong DoMe miễn phí";
      case Onboarding_page_position.page2:
        return "Trong Uptodo, bạn có thể tạo thói quen cá nhân của mình để duy trì năng suất";
      case Onboarding_page_position.page3:
        return "Bạn có thể sắp xếp các công việc hàng ngày của mình bằng cách thêm các công việc vào các danh mục riêng";
    }
  }
}
