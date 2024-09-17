// features/splash/presentation/pages/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:serkouhacote/core/theme/assetsLink.dart';
import '../bloc/splashBlock.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()
        ..add(SplashStarted()), // Create and initialize SplashBloc
      // SplashBloc을 생성하고 초기화합니다.
      child: Scaffold(
        body: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashCompleted) {
              GoRouter.of(context)
                  .pushReplacement('/home'); // Navigate to home screen
              // 홈 화면으로 이동합니다.
            }
          },
          builder: (context, state) {
            return Center(
              child: Lottie.asset(githubimage), // Display Lottie animation
              // Lottie 애니메이션을 표시합니다.
            );
          },
        ),
      ),
    );
  }
}
