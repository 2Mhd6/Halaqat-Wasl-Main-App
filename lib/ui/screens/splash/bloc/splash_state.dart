part of 'splash_bloc.dart';

sealed class SplashState {
}

final class SplashInitial extends SplashState {}

final class  SplashEndedState extends SplashState{}
