import 'package:dio/dio.dart';
import 'package:serkouhacote/core/utils/Urls.dart';
import 'package:serkouhacote/features/users/data/models/user_model.dart';

// Define the abstract class for user data source
// 사용자 데이터 소스를 위한 추상 클래스 정의
abstract class UserRemoteDataSource {
  Future<List<UserModel>> fetchUsers(int page, int perPage);
}

// Implement the UserRemoteDataSource using Dio
// Dio를 사용하여 UserRemoteDataSource를 구현
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<List<UserModel>> fetchUsers(int page, int perPage) async {
    try {
      // Fetch user data from the API with pagination
      // 페이지네이션을 적용하여 API에서 사용자 데이터를 가져옵니다.
      final response = await dio.get(
        '$mainurl',
        queryParameters: {'per_page': perPage, 'page': page},
      );
      // Parse the response data into a list of UserModel objects
      // 응답 데이터를 UserModel 객체 리스트로 파싱합니다.
      final List<dynamic> data = response.data;
      return data.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      // Handle any exceptions that occur during the API call
      // API 호출 중 발생하는 예외를 처리합니다.
      throw Exception('Failed to load users: $e');
    }
  }
}
