class RepositoryModel {
  final String name;
  final String description;
  final int stargazersCount;
  final String language;

  // Constructor for RepositoryModel
  // RepositoryModel의 생성자
  RepositoryModel({
    required this.name,
    required this.description,
    required this.stargazersCount,
    required this.language,
  });

  // Factory method to create a RepositoryModel from a JSON map
  // JSON 맵에서 RepositoryModel을 생성하는 팩토리 메서드
  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      // Get 'name' from JSON or use 'No name' if it's missing
      // JSON에서 'name'을 가져오거나 없으면 'No name'을 사용합니다.
      name: json['name'] ?? 'No name',
      // Get 'description' from JSON or use 'No description' if it's missing
      // JSON에서 'description'을 가져오거나 없으면 'No description'을 사용합니다.
      description: json['description'] ?? 'No description',
      // Get 'stargazers_count' from JSON or use 0 if it's missing
      // JSON에서 'stargazers_count'을 가져오거나 없으면 0을 사용합니다.
      stargazersCount: json['stargazers_count'] ?? 0,
      // Get 'language' from JSON or use 'Unknown' if it's missing
      // JSON에서 'language'를 가져오거나 없으면 'Unknown'을 사용합니다.
      language: json['language'] ?? 'Unknown',
    );
  }
}
