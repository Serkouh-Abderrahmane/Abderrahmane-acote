import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:serkouhacote/features/users/domain/repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository repository;

  // Constructor to initialize the ProfileRepository
  // ProfileRepository를 초기화하는 생성자
  GetProfile(this.repository);

  // Retrieves the user profile information based on the provided username
  // 제공된 사용자 이름을 기반으로 사용자 프로필 정보를 검색합니다
  Future<User> call(String userName) async {
    return await repository.getUser(userName);
  }

  // Retrieves a list of repositories for the given username
  // 주어진 사용자 이름에 대한 리포지토리 목록을 검색합니다
  Future<List<Repository>> callRepositories(String userName) async {
    return await repository.getRepositories(userName);
  }
}
