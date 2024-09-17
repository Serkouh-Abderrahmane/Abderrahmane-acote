import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:serkouhacote/core/theme/Colors.dart';
import 'package:serkouhacote/features/users/domain/repositories/profile_repository.dart';
import 'package:serkouhacote/features/users/domain/usecases/get_profile.dart';
import 'package:serkouhacote/features/users/presentation/bloc/profile_bloc.dart';
import 'package:serkouhacote/features/users/presentation/widgets/LoadingWidget.dart';
import 'package:serkouhacote/features/users/presentation/widgets/actions.dart';
import 'package:serkouhacote/features/users/presentation/widgets/custom_profile_header.dart';

// ProfileScreen displays a user's profile information
// ProfileScreen은 사용자의 프로필 정보를 표시합니다
class ProfileScreen extends StatelessWidget {
  final String userName;

  // Constructor to accept the username as a parameter
  // 사용자 이름을 매개변수로 받는 생성자
  const ProfileScreen({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // Get ProfileBloc instance from GetIt service locator
        // GetIt 서비스 로케이터에서 ProfileBloc 인스턴스 가져오기
        final bloc = GetIt.instance<ProfileBloc>();
        bloc.add(LoadProfile(userName)); // Trigger loading profile data
        // 프로필 데이터 로드를 트리거
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: AppColors.primaryBlack, // AppBar color
          // AppBar 색상
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              // Show loading widget when profile is loading
              // 프로필 로딩 중에 로딩 위젯 표시
              return Center(child: DotLoadingWidget());
            } else if (state is ProfileLoaded) {
              // Display profile information and actions when profile is loaded
              // 프로필 로드 완료 시 프로필 정보 및 작업 표시
              return Container(
                height: double.infinity,
                color: AppColors.primaryGray, // Background color
                // 배경 색상
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12), // Spacing
                      CustomProfileHeader(
                          user: state.user), // Profile header widget
                      const SizedBox(height: 16), // Spacing
                      ActionsList(
                          repositories:
                              state.repositories), // Actions list widget
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              // Show error message if there is an error loading the profile
              // 프로필 로드 중 오류가 발생하면 오류 메시지 표시
              return Center(child: Text(state.message));
            }
            // Display a fallback message for unexpected states
            // 예상치 못한 상태에 대한 대체 메시지 표시
            return Center(child: Text('Unexpected state'));
          },
        ),
      ),
    );
  }
}
