// Represents a general failure.
// 일반적인 실패를 나타냅니다.
class Failure {
  // Error message.
  // 오류 메시지입니다.
  final String message;

  // Constructor.
  // 생성자입니다.
  Failure(this.message);
}

// Represents a network-related failure.
// 네트워크 관련 실패를 나타냅니다.
class NetworkFailure extends Failure {
  // Constructor.
  // 생성자입니다.
  NetworkFailure(String message) : super(message);
}
