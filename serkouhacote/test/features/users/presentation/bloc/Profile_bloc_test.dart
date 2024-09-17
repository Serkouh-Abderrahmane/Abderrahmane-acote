import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:serkouhacote/features/users/domain/repositories/profile_repository.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_profile.dart';
import 'package:serkouhacote/features/users/presentation/bloc/profile_bloc.dart';

// Mock 클래스 (Mock classes)
class MockProfileRepository extends Mock implements ProfileRepository {}

// 테스트를 위한 샘플 사용자 및 저장소 데이터 (Sample user and repositories data for testing)
final User testUser = User(
  id: 1,
  name: 'John Doe',
  avatarUrl: 'http://example.com/avatar.jpg',
);

final List<Repository> testRepositories = [
  Repository(
      language: "En",
      stargazersCount: 2,
      name: 'Repo1',
      description: 'Description of Repo1'),
  Repository(
      language: "fr",
      stargazersCount: 8,
      name: 'Repo2',
      description: 'Description of Repo2'),
];

void TestListUi() {
  late ProfileBloc profileBloc;
  late MockProfileRepository mockProfileRepository;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    profileBloc = ProfileBloc(repository: mockProfileRepository);
  });

  test('초기 상태는 ProfileInitial이어야 한다 (Initial state should be ProfileInitial)',
      () {
    expect(profileBloc.state, equals(ProfileInitial()));
  });

  group('LoadProfile', () {
    test(
        '프로필이 성공적으로 가져오면 [ProfileLoading, ProfileLoaded] 상태가 방출되어야 한다 (Emits [ProfileLoading, ProfileLoaded] when profile is successfully fetched)',
        () async {
      // Arrange
      // 데이터 준비 (Set up mock responses)
      when(mockProfileRepository.getUser('john_doe'))
          .thenAnswer((_) async => testUser);
      when(mockProfileRepository.getRepositories('john_doe'))
          .thenAnswer((_) async => testRepositories);

      // Act
      // 액션 (Trigger the event)
      profileBloc.add(LoadProfile('john_doe'));

      // Assert
      // 결과 확인 (Verify the expected states)
      await expectLater(
        profileBloc.stream,
        emitsInOrder([
          ProfileLoading(),
          ProfileLoaded(testUser, testRepositories),
        ]),
      );
    });

    test(
        '오류가 발생하면 [ProfileLoading, ProfileError] 상태가 방출되어야 한다 (Emits [ProfileLoading, ProfileError] when an error occurs)',
        () async {
      // Arrange
      // 데이터 준비 (Set up mock responses to throw errors)
      when(mockProfileRepository.getUser('john_doe'))
          .thenThrow(Exception('Error'));
      when(mockProfileRepository.getRepositories('john_doe'))
          .thenThrow(Exception('Error'));

      // Act
      // 액션 (Trigger the event)
      profileBloc.add(LoadProfile('john_doe'));

      // Assert
      // 결과 확인 (Verify the expected states)
      await expectLater(
        profileBloc.stream,
        emitsInOrder([
          ProfileLoading(),
          ProfileError('An error occurred: Exception: Error'),
        ]),
      );
    });
  });
}
