class UserModel {
  final int id;
  final String name;
  final String avatarUrl;

  // Constructor for UserModel
  // UserModel의 생성자
  UserModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  // Factory method to create a UserModel from a JSON map
  // JSON 맵에서 UserModel을 생성하는 팩토리 메서드
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // Get 'id' from JSON
      // JSON에서 'id'를 가져옵니다.
      id: json['id'],
      // Get 'login' from JSON and use it as 'name'
      // JSON에서 'login'을 가져오고 'name'으로 사용합니다.
      name: json['login'],
      // Get 'avatar_url' from JSON
      // JSON에서 'avatar_url'을 가져옵니다.
      avatarUrl: json['avatar_url'],
    );
  }
}
