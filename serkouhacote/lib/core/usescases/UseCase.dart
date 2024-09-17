// Abstract class that defines the contract for a use case.
// This class represents a generic use case with a method that performs an action and returns a result.
// 추상 클래스는 유스 케이스의 계약을 정의합니다.
// 이 클래스는 작업을 수행하고 결과를 반환하는 메서드를 가진 일반적인 유스 케이스를 나타냅니다.
abstract class UseCase<Type, Params> {
  // Method that executes the use case with the provided parameters and returns a result of type [Type].
  // The [Params] is the input for the use case, and [Type] is the output.
  // 제공된 매개변수로 유스 케이스를 실행하고 [Type] 유형의 결과를 반환하는 메서드입니다.
  // [Params]는 유스 케이스의 입력이고, [Type]은 출력입니다.
  Future<Type> call(Params params);
}
