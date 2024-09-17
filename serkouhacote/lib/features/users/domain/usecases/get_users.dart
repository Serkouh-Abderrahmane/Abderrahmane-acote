import 'package:serkouhacote/core/usescases/UseCase.dart';
import 'package:serkouhacote/core/utils/Failure.dart';
import 'package:serkouhacote/features/users/data/repositories/user_repository.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:dartz/dartz.dart';

// Use case for fetching a list of users
// 사용자 목록을 가져오기 위한 유스케이스
class GetUsers {
  final UserRepository repository;

  // Constructor to initialize the UserRepository
  // UserRepository를 초기화하는 생성자
  GetUsers(this.repository);

  // Fetches a list of users from the repository with pagination
  // 페이지네이션을 사용하여 리포지토리에서 사용자 목록을 가져옵니다
  Future<Either<Failure, List<User>>> call(int page, int perPage) async {
    return await repository.getUsers(page, perPage);
  }
}

// Parameters required for fetching users
// 사용자를 가져오기 위해 필요한 파라미터
class GetUsersParams {
  final int page;
  final int perPage;

  // Constructor to initialize the parameters
  // 파라미터를 초기화하는 생성자
  GetUsersParams({required this.page, required this.perPage});
}
