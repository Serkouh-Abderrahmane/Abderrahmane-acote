// Abstract class representing the base event for user-related actions
// 사용자 관련 작업의 기본 이벤트를 나타내는 추상 클래스
abstract class UserEvent {}

// Event indicating that a request to load the initial set of users has been made
// 초기 사용자 목록을 로드하라는 요청을 나타내는 이벤트
class LoadUsers extends UserEvent {}

// Event indicating that a request to load more users (pagination) has been made
// 추가 사용자를 로드하라는 요청을 나타내는 이벤트 (페이지네이션)
class LoadMoreUsers extends UserEvent {}
