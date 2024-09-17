import 'package:serkouhacote/features/users/data/models/user_model.dart';

class User {
  final int id;
  final String name;
  final String avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });
  factory User.fromModel(UserModel model) {
    return User(
      id: model.id,
      name: model.name,
      avatarUrl: model.avatarUrl,
    );
  }
}
