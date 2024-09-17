import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serkouhacote/features/splash/presentation/pages/SplashScrean.dart';
import 'package:serkouhacote/features/users/presentation/pages/Home.dart';
import 'package:serkouhacote/features/users/presentation/pages/profile_screen.dart';
import 'package:serkouhacote/features/users/presentation/widgets/AdvertWidget.dart';
import 'package:serkouhacote/features/users/presentation/widgets/LoadingWidget.dart';
import 'package:serkouhacote/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'Splash screen transitions to Home, and Home screen functionality works',
      (WidgetTester tester) async {
    // Launch the app and wait for the SplashScreen to show
    // 앱을 실행하고 SplashScreen이 표시될 때까지 기다립니다.
    app.main();
    await tester.pumpAndSettle(); // Wait for the app to settle
    // 앱이 안정될 때까지 기다립니다.

    // Verify SplashScreen and wait for it to transition to Home
    // SplashScreen이 표시되는지 확인하고 Home으로 전환될 때까지 기다립니다.
    expect(find.byType(SplashScreen), findsOneWidget);
    await tester.pumpAndSettle(); // Wait for transition
    // 전환이 완료될 때까지 기다립니다.

    // Ensure the Home screen is displayed
    // Home 화면이 표시되는지 확인합니다.
    expect(find.byType(Home), findsOneWidget);

    // Check if the loading indicator is displayed initially
    // 초기 로딩 인디케이터가 표시되는지 확인합니다.
    expect(find.byType(DotLoadingWidget), findsOneWidget);

    // Simulate loading more users by scrolling
    // 스크롤하여 더 많은 사용자를 로드하는 것을 시뮬레이션합니다.
    final scrollable = find.byType(Scrollable).first;
    await tester.drag(
        scrollable, Offset(0, -300)); // Scroll up to trigger loading more
    // 스크롤하여 더 많은 사용자를 로드하도록 트리거합니다.
    await tester.pumpAndSettle(); // Wait for the loading to complete
    // 로딩이 완료될 때까지 기다립니다.

    // Verify that user items are displayed in the list
    // 사용자 항목이 목록에 표시되는지 확인합니다.
    expect(find.byType(ListTile), findsWidgets);

    // Verify the FloatingActionButton and click it to reload
    // FloatingActionButton을 확인하고 클릭하여 새로 고침합니다.
    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);
    await tester.tap(fab);
    await tester.pumpAndSettle(); // Wait for the reload to complete
    // 새로 고침이 완료될 때까지 기다립니다.

    // Verify that an ad is displayed at the correct interval (every 10 items)
    // 광고가 올바른 간격(10개 항목마다)으로 표시되는지 확인합니다.
    expect(find.byType(Clickable_AD_Image),
        findsWidgets); // Check if ad is present
    // 광고가 표시되는지 확인합니다.

    // Interact with a user item and check for navigation
    // 사용자 항목과 상호 작용하고 탐색을 확인합니다.
    final firstUser = find.byType(ListTile).first;
    await tester.tap(firstUser);
    await tester.pumpAndSettle(); // Wait for navigation to complete
    // 탐색이 완료될 때까지 기다립니다.

    // Ensure ProfileScreen is displayed
    // ProfileScreen이 표시되는지 확인합니다.
    expect(find.byType(ProfileScreen), findsOneWidget);

    // Optionally, verify some elements on the ProfileScreen if needed
    // 필요에 따라 ProfileScreen의 일부 요소를 확인할 수 있습니다.
    // For example:
    // expect(find.text('Profile'), findsOneWidget);
  });
}
