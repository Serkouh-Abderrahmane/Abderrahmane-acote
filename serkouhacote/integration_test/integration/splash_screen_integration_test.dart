import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:go_router/go_router.dart';
import 'package:serkouhacote/features/splash/presentation/pages/SplashScrean.dart';
import 'package:serkouhacote/features/splash/presentation/bloc/splashBlock.dart'; // Adjust import as needed
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'dart:async'; // Import for StreamController

// Mock class for SplashBloc
// SplashBloc을 위한 모의 클래스
class MockSplashBloc extends Mock implements SplashBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'SplashScreen shows animation and navigates to home when SplashCompleted state is emitted',
      (WidgetTester tester) async {
    // Create a mock SplashBloc
    // 모의 SplashBloc을 생성합니다.
    final mockSplashBloc = MockSplashBloc();
    final streamController = StreamController<SplashState>();

    // Define the SplashCompleted state
    // SplashCompleted 상태를 정의합니다.
    final splashCompletedState = SplashCompleted();

    // Use StreamController to simulate the bloc stream
    // StreamController를 사용하여 bloc 스트림을 시뮬레이션합니다.
    when(mockSplashBloc.stream).thenAnswer((_) => streamController.stream);
    when(mockSplashBloc.state).thenReturn(SplashInitial()); // Initial state
    // 초기 상태를 설정합니다.

    // Build the widget tree
    // 위젯 트리를 빌드합니다.
    await tester.pumpWidget(
      MaterialApp.router(
        routerDelegate: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => BlocProvider<SplashBloc>.value(
                value: mockSplashBloc,
                child: SplashScreen(),
              ),
            ),
            GoRoute(
              path: '/home',
              builder: (context, state) => Scaffold(body: Text('Home Page')),
            ),
          ],
        ).routerDelegate,
        routeInformationParser: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => BlocProvider<SplashBloc>.value(
                value: mockSplashBloc,
                child: SplashScreen(),
              ),
            ),
            GoRoute(
              path: '/home',
              builder: (context, state) => Scaffold(body: Text('Home Page')),
            ),
          ],
        ).routeInformationParser,
        theme: ThemeData(useMaterial3: false),
      ),
    );

    // Simulate state change
    // 상태 변경을 시뮬레이션합니다.
    await Future.delayed(Duration(milliseconds: 100));
    streamController.add(splashCompletedState);

    // Verify if the Lottie animation is displayed initially
    // Lottie 애니메이션이 처음에 표시되는지 확인합니다.
    expect(find.byType(Lottie), findsOneWidget);

    // Allow the widget to process state changes and navigation
    // 위젯이 상태 변경 및 내비게이션을 처리할 수 있도록 합니다.
    await tester.pump(); // Initial pump to build the widget
    await tester
        .pumpAndSettle(); // Ensure all animations and navigation complete

    // Verify navigation to the home page
    // 홈 페이지로의 내비게이션을 확인합니다.
    expect(find.text('Home Page'), findsOneWidget);

    // Clean up
    // 정리합니다.
    await streamController.close();
  });
}
