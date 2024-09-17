import 'package:serkouhacote/core/network/NetworkInfo.dart';
import 'package:serkouhacote/core/utils/Failure.dart';
import 'package:serkouhacote/features/users/data/datasources/user_remote_data_source.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers(int page, int perPage);
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  // Constructor for UserRepositoryImpl
  // UserRepositoryImpl의 생성자
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>>> getUsers(int page, int perPage) async {
    // Check network connectivity
    // 네트워크 연결 상태 확인
    if (await networkInfo.isConnected) {
      try {
        // Fetch users from remote data source
        // 원격 데이터 소스에서 사용자 데이터 가져오기
        final remoteUsers = await remoteDataSource.fetchUsers(page, perPage);

        // Convert the fetched data to a list of User entities and return it
        // 가져온 데이터를 User 엔티티 목록으로 변환하여 반환
        return Right(
            remoteUsers.map((model) => User.fromModel(model)).toList());
      } catch (e) {
        // Handle any exceptions and return a NetworkFailure
        // 예외 발생 시 처리하고 NetworkFailure 반환
        return Left(NetworkFailure('Failed to fetch users.'));
      }
    } else {
      // Return a NetworkFailure if there is no network connection
      // 네트워크 연결이 없으면 NetworkFailure 반환
      return Left(NetworkFailure('No network connection.'));
    }
  }
}
