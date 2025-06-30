part of 'splash_bloc.dart';

sealed class SplashEvent {
  }

// Event to start the splash screen
  class SplashStartedEvent extends SplashEvent{} 
// Event to finish the splash screen
  class SplashEndedEvent extends SplashEvent{}
