import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> { 
  SplashBloc() : super(SplashInitial()) {
    // Handle SplashStartedEvent
    on<SplashStartedEvent>((event, emit) {
      Future.delayed(Duration(milliseconds: 5000), () {
        add(SplashEndedEvent());
      });
    });

     // Handle SplashEndedEvent
    on<SplashEndedEvent>((event, emit) {
     // Emit SplashEndedState to notify splash ended
      emit(SplashEndedState());
    });
  }
}
