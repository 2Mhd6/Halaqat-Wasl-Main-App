part of 'onboard_bloc.dart';


//It compares events to determine if there is a change in state.
@immutable
sealed class OnboardState {}
   

class FirstOnboardState   extends OnboardState{}
class SecondOnboardState   extends OnboardState{}
class ThirdOnboardState   extends OnboardState{}
class EndOnboardState   extends OnboardState{}




