import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:serkouhacote/core/theme/Colors.dart'; // Import the custom color theme

/// A widget that displays a dot-based loading animation.
/// 점 기반 로딩 애니메이션을 표시하는 위젯입니다.
class DotLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return JumpingDots(
      color: AppColors.primaryBlack, // Use primary black color from theme.
      // 테마에서 기본 검정색을 사용합니다.
      radius: 10, // Set the size of each dot.
      // 각 점의 크기를 설정합니다.
      numberOfDots: 3, // Number of dots to display in the animation.
      // 애니메이션에 표시할 점의 수를 설정합니다.
      animationDuration:
          Duration(milliseconds: 200), // Duration for the bouncing animation.
      // 점의 튕기는 애니메이션 지속 시간을 설정합니다.
    );
  }
}
