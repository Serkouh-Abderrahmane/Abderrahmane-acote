import 'package:serkouhacote/core/utils/Urls.dart';
import 'package:serkouhacote/features/users/data/models/repository_model.dart';
import 'package:serkouhacote/features/users/data/models/user_model.dart';
import 'package:dio/dio.dart';

// Define the abstract class for profile data source
// 프로필 데이터 소스를 위한 추상 클래스 정의
abstract class ProfileRemoteDataSource {
  Future<UserModel> fetchUser(String userName);
  Future<List<RepositoryModel>> fetchRepositories(String userName);
}

// Implement the ProfileRemoteDataSource using Dio
// Dio를 사용하여 ProfileRemoteDataSource를 구현
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> fetchUser(String userName) async {
    try {
      // Fetch user data from the API
      // API에서 사용자 데이터를 가져옵니다.
      final response = await dio.get('$mainurl/$userName');
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  @override
  Future<List<RepositoryModel>> fetchRepositories(String userName) async {
    try {
      // Fetch repositories data from the API
      // API에서 리포지토리 데이터를 가져옵니다.
      final response = await dio.get('$mainurl/$userName/repos');
      if (response.statusCode == 200) {
        final List<dynamic> repositoriesJson = response.data;
        return repositoriesJson
            .map((json) => RepositoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load repositories');
      }
    } catch (e) {
      throw Exception('Failed to load repositories: $e');
    }
  }
}
