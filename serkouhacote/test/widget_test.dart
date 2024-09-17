import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_users.dart';
import 'package:serkouhacote/features/users/presentation/bloc/user_bloc.dart';
import 'package:serkouhacote/features/users/presentation/bloc/user_state.dart';
import 'package:serkouhacote/features/users/presentation/bloc/userevent.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:serkouhacote/features/users/presentation/pages/Home.dart';
import 'package:serkouhacote/features/users/presentation/widgets/AdvertWidget.dart';

// Mock 클래스 정의 (Mock classes)
class MockGetUsers extends Mock implements GetUsers {}

class MockUserBloc extends Mock implements UserBloc {}

void main() {
  late MockUserBloc mockUserBloc;
  late MockGetUsers mockGetUsers;

  // 테스트 환경 설정 (Set up the test environment)
  setUp(() {
    mockUserBloc = MockUserBloc();
    mockGetUsers = MockGetUsers();
  });

  // 테스트할 위젯 생성 (Create the widget under test)
  Widget createWidgetUnderTest() {
    return BlocProvider<UserBloc>(
      create: (context) => mockUserBloc,
      child: MaterialApp(home: Home()),
    );
  }

  // UserLoading 상태일 때 로딩 위젯이 표시되는지 테스트 (Should display loading widget when UserLoading state is emitted)
  testWidgets('should display loading widget when UserLoading state is emitted',
      (WidgetTester tester) async {
    // Arrange
    // UserLoading 상태를 반환하도록 설정 (Set up to return UserLoading state)
    when(mockUserBloc.state).thenReturn(UserLoading());

    // Act
    // 위젯을 테스트 환경에 주입 (Inject widget into the test environment)
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // 프레임을 트리거 (Trigger a frame)

    // Assert
    // CircularProgressIndicator가 표시되는지 확인 (Verify that CircularProgressIndicator is displayed)
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // UserError 상태일 때 오류 메시지가 표시되는지 테스트 (Should display error message when UserError state is emitted)
  testWidgets('should display error message when UserError state is emitted',
      (WidgetTester tester) async {
    // Arrange
    // UserError 상태를 반환하도록 설정 (Set up to return UserError state)
    when(mockUserBloc.state).thenReturn(UserError('An error occurred'));

    // Act
    // 위젯을 테스트 환경에 주입 (Inject widget into the test environment)
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // 프레임을 트리거 (Trigger a frame)

    // Assert
    // 오류 메시지가 표시되는지 확인 (Verify that the error message is displayed)
    expect(find.text('An error occurred'), findsOneWidget);
  });

  // UserLoaded 상태일 때 사용자 목록이 표시되는지 테스트 (Should display list of users when UserLoaded state is emitted)
  testWidgets('should display list of users when UserLoaded state is emitted',
      (WidgetTester tester) async {
    // Arrange
    final users = [
      User(id: 1, name: 'User 1', avatarUrl: 'http://example.com/user1.jpg'),
      User(id: 2, name: 'User 2', avatarUrl: 'http://example.com/user2.jpg'),
    ];
    // UserLoaded 상태를 반환하도록 설정 (Set up to return UserLoaded state with users)
    when(mockUserBloc.state)
        .thenReturn(UserLoaded(users: users, hasMore: false));

    // Act
    // 위젯을 테스트 환경에 주입 (Inject widget into the test environment)
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // 프레임을 트리거 (Trigger a frame)

    // Assert
    // 사용자 목록이 표시되는지 확인 (Verify that the list of users is displayed)
    expect(find.text('User 1'), findsOneWidget);
    expect(find.text('User 2'), findsOneWidget);
  });

  // 10명의 사용자마다 클릭 가능한 광고 위젯이 표시되는지 테스트 (Should display a clickable ad widget every 10 users)
  testWidgets('should display a clickable ad widget every 10 users',
      (WidgetTester tester) async {
    // Arrange
    final users = List.generate(
      20,
      (index) => User(
          id: index,
          name: 'User $index',
          avatarUrl: 'http://example.com/user$index.jpg'),
    );
    // UserLoaded 상태를 반환하도록 설정 (Set up to return UserLoaded state with 20 users)
    when(mockUserBloc.state)
        .thenReturn(UserLoaded(users: users, hasMore: false));

    // Act
    // 위젯을 테스트 환경에 주입 (Inject widget into the test environment)
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // 프레임을 트리거 (Trigger a frame)

    // Assert
    // Clickable_AD_Image 위젯이 표시되는지 확인 (Verify that Clickable_AD_Image widget is displayed)
    expect(find.byType(Clickable_AD_Image), findsOneWidget);
  });

  // FloatingActionButton 클릭 시 LoadUsers 이벤트가 호출되는지 테스트 (Should call LoadUsers event when floating action button is pressed)
  testWidgets(
      'should call LoadUsers event when floating action button is pressed',
      (WidgetTester tester) async {
    // Arrange
    // UserLoaded 상태를 반환하도록 설정 (Set up to return UserLoaded state with no users)
    when(mockUserBloc.state).thenReturn(UserLoaded(users: [], hasMore: false));

    // Act
    // 위젯을 테스트 환경에 주입 (Inject widget into the test environment)
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // 프레임을 트리거 (Trigger a frame)

    final fabFinder = find.byType(FloatingActionButton);
    expect(fabFinder, findsOneWidget);

    // FloatingActionButton 클릭 (Tap the FloatingActionButton)
    await tester.tap(fabFinder);
    await tester.pump(); // 위젯 재빌드 (Rebuild the widget)

    // Assert
    // LoadUsers 이벤트가 호출되는지 확인 (Verify that LoadUsers event is called)
    verify(mockUserBloc.add(LoadUsers())).called(1);
  });
}
