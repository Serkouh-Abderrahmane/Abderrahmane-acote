import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:serkouhacote/core/network/NetworkInfo.dart';
import 'package:serkouhacote/core/utils/Failure.dart';
import 'package:serkouhacote/features/users/data/datasources/user_remote_data_source.dart';
import 'package:serkouhacote/features/users/data/models/user_model.dart';
import 'package:serkouhacote/features/users/data/repositories/user_repository.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

@GenerateMocks([UserRemoteDataSource, NetworkInfo])
void TestGetUsers() {
  late UserRepositoryImpl repository;
  late MockUserRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getUsers', () {
    final tPage = 1;
    final tPerPage = 10;
    final tUserModel = UserModel(id: 8, name: 'John Doe', avatarUrl: 'url');
    final tRemoteModels = [tUserModel];
    final tUsers = [User.fromModel(tUserModel)];

    test(
        'should return list of users when the call to remote data source is successful',
        () async {
      print("testing connection");
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.fetchUsers(tPage, tPerPage))
          .thenAnswer((_) async => tRemoteModels);

      print(
          'Before Act: NetworkInfo.isConnected: ${await mockNetworkInfo.isConnected}');
      print(
          'Before Act: MockRemoteDataSource.fetchUsers called with: $tPage, $tPerPage');

      // Act
      final result = await repository.getUsers(tPage, tPerPage);

      // Assert
      print('After Act: Result: $result');

      expect(result, Right(tUsers));
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.fetchUsers(tPage, tPerPage));
    });

    test('should return a NetworkFailure when there is no network connection',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      print(
          'Before Act: NetworkInfo.isConnected: ${await mockNetworkInfo.isConnected}');

      // Act
      final result = await repository.getUsers(tPage, tPerPage);

      // Assert
      print('After Act: Result: $result');

      expect(result, Left(NetworkFailure('No network connection.')));
      verify(mockNetworkInfo.isConnected);
      verifyNever(mockRemoteDataSource.fetchUsers(tPage, tPerPage));
    });

    test(
        'should return a NetworkFailure when fetching users throws an exception',
        () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.fetchUsers(tPage, tPerPage))
          .thenThrow(Exception('Error'));

      print(
          'Before Act: NetworkInfo.isConnected: ${await mockNetworkInfo.isConnected}');
      print(
          'Before Act: MockRemoteDataSource.fetchUsers called with: $tPage, $tPerPage');

      // Act
      final result = await repository.getUsers(tPage, tPerPage);

      // Assert
      print('After Act: Result: $result');

      expect(result, Left(NetworkFailure('Failed to fetch users.')));
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.fetchUsers(tPage, tPerPage));
    });
  });
}
