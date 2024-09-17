import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/presentation/widgets/cabinet_proposal_card.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CabinetProposalCard displays repository data correctly',
      (WidgetTester tester) async {
    // Define a test repository
    // 테스트용 저장소를 정의합니다.
    final testRepository = Repository(
      name: 'Test Repo',
      description: 'This is a test repository description.',
      language: 'Dart',
      stargazersCount: 123,
    );

    // Build the CabinetProposalCard widget
    // CabinetProposalCard 위젯을 빌드합니다.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CabinetProposalCard(repository: testRepository),
        ),
      ),
    );

    // Verify if the repository name is displayed
    // 저장소 이름이 표시되는지 확인합니다.
    expect(find.text('Test Repo'), findsOneWidget);

    // Verify if the repository description is displayed
    // 저장소 설명이 표시되는지 확인합니다.
    expect(find.text('This is a test repository description.'), findsOneWidget);

    // Verify if the repository language is displayed
    // 저장소 언어가 표시되는지 확인합니다.
    expect(find.text('Dart'), findsOneWidget);

    // Verify if the stargazers count is displayed with a star icon
    // 별 아이콘과 함께 stargazers 수가 표시되는지 확인합니다.
    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.text('123'), findsOneWidget);
  });
}
