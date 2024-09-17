import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';

abstract class ProfileRepository {
  // Fetches a user based on the username
  // 사용자 이름을 기반으로 사용자를 가져옵니다
  Future<User> getUser(String userName);

  // Fetches a list of repositories for the given username
  // 주어진 사용자 이름에 대한 리포지토리 목록을 가져옵니다
  Future<List<Repository>> getRepositories(String userName);
}
