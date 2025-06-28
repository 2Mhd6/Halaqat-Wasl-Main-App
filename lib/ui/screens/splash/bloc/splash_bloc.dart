import 'dart:async';
import 'package:logging/logging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    var logger = Logger('Splash Bloc');

    on<SplashStartedEvent>((event, emit) {
      logger.info('Splash Started');
      Future.delayed(Duration(milliseconds: 5000), () {
        add(SplashEndedEvent());
      });
    });
    on<SplashEndedEvent>((event, emit) {
      logger.info('Splash Ended');
      emit(SplashEndedState());
    });
  }
}
