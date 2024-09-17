import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// CustomAppBar is a customizable AppBar widget
// CustomAppBar는 사용자 정의 가능한 AppBar 위젯입니다
class CostumAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Constructor to initialize the AppBar with a title and optional background color
  // 제목과 선택적 배경색으로 AppBar를 초기화하는 생성자
  CostumAppBar({super.key, required this.title, Color? color})
      : color = color ?? Colors.green.shade50;

  final String title; // The title displayed in the AppBar
  final Color color; // The background color of the AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color, // Set the background color of the AppBar
      scrolledUnderElevation:
          0.2, // Elevation when the AppBar is scrolled under
      shadowColor: Colors.green.shade50, // Shadow color of the AppBar
      elevation: 0, // Elevation of the AppBar
      title: Text(title), // Set the title of the AppBar
      leading: Container(
        margin: const EdgeInsets.all(5), // Margin around the back button
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back, // Icon for the back button
            color: Colors.white, // Color of the back button icon
          ),
          onPressed: () {
            GoRouter.of(context)
                .pop(); // Navigate back when the back button is pressed
          },
          color: Colors.black, // Color of the back button itself
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(56); // Preferred height of the AppBar
}
