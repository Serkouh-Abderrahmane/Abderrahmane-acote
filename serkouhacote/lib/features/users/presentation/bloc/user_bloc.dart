import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serkouhacote/core/utils/Failure.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_users.dart';
import 'package:serkouhacote/features/users/presentation/bloc/userevent.dart';
import 'user_state.dart';

// Bloc class to handle user-related events and states
// 사용자 관련 이벤트 및 상태를 처리하는 Bloc 클래스
class UserBloc extends Bloc<UserEvent, UserState> {
  static const int _perPage = 30; // Number of users per page
  // 페이지당 사용자 수
  int _page = 1; // Current page
  // 현재 페이지
  bool _hasMore = true; // Flag to indicate if more users are available
  // 추가 사용자 여부를 나타내는 플래그
  List<User> _users = []; // List to hold users
  // 사용자 목록을 보관하는 리스트
  final GetUsers getUsers;

  // Constructor for UserBloc
  // UserBloc의 생성자
  UserBloc({required this.getUsers}) : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers); // Handle LoadUsers event
    // LoadUsers 이벤트를 처리합니다
    on<LoadMoreUsers>(_onLoadMoreUsers); // Handle LoadMoreUsers event
    // LoadMoreUsers 이벤트를 처리합니다
  }

  // Method to handle LoadUsers event
  // LoadUsers 이벤트를 처리하는 메소드
  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    _page = 1; // Reset to the first page
    _hasMore = true; // Reset the flag to indicate more users may be available
    _users = []; // Clear the existing user list
    await _fetchUsers(emit); // Fetch users and emit states
    // 사용자 정보를 가져오고 상태를 발생시킵니다
  }

  // Method to handle LoadMoreUsers event
  // LoadMoreUsers 이벤트를 처리하는 메소드
  Future<void> _onLoadMoreUsers(
      LoadMoreUsers event, Emitter<UserState> emit) async {
    if (_hasMore) {
      _page++; // Increment the page number
      await _fetchUsers(emit); // Fetch more users and emit states
      // 추가 사용자 정보를 가져오고 상태를 발생시킵니다
    }
  }

  // Method to fetch users from the repository
  // 리포지토리에서 사용자 정보를 가져오는 메소드
  Future<void> _fetchUsers(Emitter<UserState> emit) async {
    if (_page == 1) {
      emit(UserLoading()); // Emit loading state if it's the first page
      // 첫 페이지인 경우 로딩 상태를 발생시킵니다
    }
    try {
      final failureOrUsers = await getUsers(_page, _perPage);
      // Fetch users using the GetUsers use case
      // GetUsers 유스케이스를 사용하여 사용자 정보를 가져옵니다
      failureOrUsers.fold(
        (failure) => emit(UserError(failure.message)),
        (users) {
          _hasMore =
              users.length == _perPage; // Check if more users are available
          // 추가 사용자가 있는지 확인합니다
          if (_page == 1) {
            _users = users; // Replace the user list if it's the first page
            // 첫 페이지인 경우 사용자 목록을 교체합니다
          } else {
            _users.addAll(users); // Append new users to the existing list
            // 기존 목록에 새 사용자들을 추가합니다
          }
          emit(UserLoaded(users: List.from(_users), hasMore: _hasMore));
          // Emit loaded state with the updated user list and availability flag
          // 업데이트된 사용자 목록 및 추가 가능 여부 플래그와 함께 로드된 상태를 발생시킵니다
        },
      );
    } catch (e) {
      emit(UserError(
          "Failed to fetch users.")); // Emit error state if an exception occurs
      // 예외가 발생하면 오류 상태를 발생시킵니다
    }
  }
}
