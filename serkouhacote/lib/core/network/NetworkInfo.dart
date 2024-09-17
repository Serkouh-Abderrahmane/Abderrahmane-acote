import 'package:connectivity/connectivity.dart';

// Abstract class that defines the contract for network connectivity information.
// This contract requires a method to check if the device is connected to the internet.
// 네트워크 연결 정보를 정의하는 추상 클래스입니다.
// 이 계약에는 장치가 인터넷에 연결되어 있는지 확인하는 메서드가 필요합니다.
abstract class NetworkInfo {
  // A getter that returns a Future which resolves to true if the device is connected to the internet.
  // 장치가 인터넷에 연결되어 있으면 true로 해결되는 Future를 반환하는 getter입니다.
  Future<bool> get isConnected;
}

// Concrete implementation of the NetworkInfo interface.
// This class uses the Connectivity package to check network connectivity.
// NetworkInfo 인터페이스의 구체적인 구현입니다.
// 이 클래스는 Connectivity 패키지를 사용하여 네트워크 연결 상태를 확인합니다.
class NetworkInfoImpl implements NetworkInfo {
  // The Connectivity instance used to check network status.
  // 네트워크 상태를 확인하는 데 사용되는 Connectivity 인스턴스입니다.
  final Connectivity connectivity;

  // Constructor for NetworkInfoImpl, which initializes the Connectivity instance.
  // NetworkInfoImpl의 생성자로, Connectivity 인스턴스를 초기화합니다.
  NetworkInfoImpl(this.connectivity);

  // Implementation of the isConnected getter.
  // This method asynchronously checks the current connectivity status.
  // isConnected getter의 구현입니다.
  // 이 메서드는 비동기적으로 현재 연결 상태를 확인합니다.
  @override
  Future<bool> get isConnected async {
    // Check the connectivity status using the Connectivity instance.
    // Connectivity 인스턴스를 사용하여 연결 상태를 확인합니다.
    final connectivityResult = await connectivity.checkConnectivity();

    // Return true if the device is connected to any network (Wi-Fi, mobile, etc.).
    // If no network is available, return false.
    // 장치가 네트워크(와이파이, 모바일 등)에 연결되어 있으면 true를 반환합니다.
    // 네트워크가 없으면 false를 반환합니다.
    return connectivityResult != ConnectivityResult.none;
  }
}
