import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serkouhacote/features/splash/presentation/pages/SplashScrean.dart';
import 'package:serkouhacote/features/users/presentation/pages/Home.dart';
import 'package:serkouhacote/features/users/presentation/pages/profile_screen.dart';

// GoRouter instance to define the navigation structure
// GoRouter 인스턴스는 네비게이션 구조를 정의합니다
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/', // Root path of the application
      // Builder to create the SplashScreen widget when the root path is accessed
      // 루트 경로에 접근할 때 SplashScreen 위젯을 생성하는 빌더
      builder: (context, state) => SplashScreen(),
      routes: [
        GoRoute(
            path: 'home', // Path for the home screen
            // Builder to create the Home widget when the 'home' path is accessed
            // 'home' 경로에 접근할 때 Home 위젯을 생성하는 빌더
            builder: (context, state) {
              return Home();
            },
            routes: [
              GoRoute(
                path:
                    'profile/:userName', // Path for user profile screen with userName parameter
                // Builder to create the ProfileScreen widget and pass the userName parameter
                // userName 매개변수를 전달하여 ProfileScreen 위젯을 생성하는 빌더
                builder: (context, state) {
                  final userName = state.pathParameters[
                      'userName']!; // Extract userName from path parameters
                  return ProfileScreen(
                      userName: userName); // Pass userName to ProfileScreen
                },
              ),
            ]),
      ],
    ),
  ],
  errorBuilder: (context, state) {
    // Builder to handle errors, displaying an error message
    // 오류를 처리하기 위한 빌더, 오류 메시지를 표시합니다
    return Scaffold(
      body: Center(
          child: Text(
              'Error: ${state.error}')), // Display error message in the center
      // 중앙에 오류 메시지를 표시합니다
    );
  },
);
