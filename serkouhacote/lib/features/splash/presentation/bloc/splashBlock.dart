import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class SplashEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashStarted extends SplashEvent {}

// States
abstract class SplashState extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashCompleted extends SplashState {}

// BLoC for handling splash screen events and states
// 스플래시 화면의 이벤트와 상태를 처리하는 BLoC
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>((event, emit) async {
      emit(SplashInitial()); // Emit the initial splash state
      await Future.delayed(Duration(seconds: 3)); // Wait for splash duration
      emit(SplashCompleted()); // Emit the completed state after delay
    });
  }
}
