part of 'splash_bloc.dart';

sealed class SplashEvent {
  }

  class SplashStartedEvent extends SplashEvent{}
  class SplashEndedEvent extends SplashEvent{}
