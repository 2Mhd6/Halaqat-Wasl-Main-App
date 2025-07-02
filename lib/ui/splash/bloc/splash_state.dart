part of 'splash_bloc.dart';


// Base class for all states related to SplashBloc 
sealed class SplashState {
}
// Initial state
final class SplashInitial extends SplashState {} 
//Splash state is finished and ready to navigate
final class  SplashEndedState extends SplashState{}
