import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serkouhacote/features/users/domain/entities/Repositorie.dart';
import 'package:serkouhacote/features/users/domain/entities/Users.dart';
import 'package:serkouhacote/features/users/domain/repositories/profile_repository.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_profile.dart';

// Define events
// 이벤트를 정의합니다
abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String userName;
  LoadProfile(this.userName);
}

// Define states
// 상태를 정의합니다
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  final List<Repository> repositories;

  // Constructor for ProfileLoaded state
  // ProfileLoaded 상태를 위한 생성자
  ProfileLoaded(this.user, this.repositories);
}

class ProfileError extends ProfileState {
  final String message;

  // Constructor for ProfileError state
  // ProfileError 상태를 위한 생성자
  ProfileError(this.message);
}

// Bloc to handle profile-related events and states
// 프로필 관련 이벤트와 상태를 처리하는 Bloc입니다
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  // Constructor to initialize the repository
  // 리포지토리를 초기화하는 생성자
  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile); // Handle LoadProfile event
    // LoadProfile 이벤트를 처리합니다
  }

  // Method to handle LoadProfile event
  // LoadProfile 이벤트를 처리하는 메소드
  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading()); // Emit loading state
    // 로딩 상태를 발생시킵니다
    try {
      final user = await repository.getUser(event.userName);
      final repositories = await repository.getRepositories(event.userName);
      emit(ProfileLoaded(
          user, repositories)); // Emit loaded state with user and repositories
      // 사용자와 리포지토리와 함께 로드된 상태를 발생시킵니다
    } catch (e) {
      emit(ProfileError(
          "An error occurred: $e")); // Emit error state if exception occurs
      // 예외가 발생하면 오류 상태를 발생시킵니다
    }
  }
}
