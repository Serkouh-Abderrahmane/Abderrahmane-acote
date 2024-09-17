import 'package:serkouhacote/features/users/domain/entities/Users.dart';

// Abstract class representing the base state for user-related operations
// 사용자 관련 작업의 기본 상태를 나타내는 추상 클래스
abstract class UserState {}

// Represents the initial state when the UserBloc is first created
// UserBloc이 처음 생성될 때의 초기 상태를 나타냅니다
class UserInitial extends UserState {}

// Represents the loading state when user data is being fetched
// 사용자 데이터를 가져오는 동안의 로딩 상태를 나타냅니다
class UserLoading extends UserState {}

// Represents the state when user data has been successfully loaded
// 사용자 데이터가 성공적으로 로드된 상태를 나타냅니다
class UserLoaded extends UserState {
  final List<User> users; // List of users that have been fetched
  // 가져온 사용자 목록
  final bool hasMore; // Indicates if there are more users to load
  // 추가로 로드할 사용자가 있는지 여부

  UserLoaded({required this.users, required this.hasMore});
}

// Represents an error state when there is a failure in fetching user data
// 사용자 데이터 가져오기 실패 시의 오류 상태를 나타냅니다
class UserError extends UserState {
  final String message; // Error message describing the issue
  // 문제를 설명하는 오류 메시지

  UserError(this.message);
}
