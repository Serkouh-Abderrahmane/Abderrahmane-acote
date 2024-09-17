import 'package:serkouhacote/features/users/data/datasources/profile_remote_data_source.dart';
import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';

import 'package:serkouhacote/features/users/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  // Constructor for ProfileRepositoryImpl
  // ProfileRepositoryImpl의 생성자
  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> getUser(String userName) async {
    // Fetch user data from remote data source
    // 원격 데이터 소스에서 사용자 데이터를 가져옵니다.
    final userModel = await remoteDataSource.fetchUser(userName);

    // Map the fetched UserModel to User entity
    // 가져온 UserModel을 User 엔티티로 변환합니다.
    return User(
      id: userModel.id,
      name: userModel.name,
      avatarUrl: userModel.avatarUrl,
    );
  }

  @override
  Future<List<Repository>> getRepositories(String userName) async {
    // Fetch repository data from remote data source
    // 원격 데이터 소스에서 저장소 데이터를 가져옵니다.
    final repositoryModels = await remoteDataSource.fetchRepositories(userName);

    // Map the fetched list of RepositoryModel to a list of Repository entities
    // 가져온 RepositoryModel 목록을 Repository 엔티티 목록으로 변환합니다.
    return repositoryModels
        .map((model) => Repository(
              name: model.name,
              description: model.description,
              stargazersCount: model.stargazersCount,
              language: model.language,
            ))
        .toList();
  }
}
