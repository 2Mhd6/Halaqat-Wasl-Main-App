part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class SuccessTogglingPasswordViability extends AuthState{}

final class SuccessSelectingGender extends AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingState extends AuthState{}

final class SuccessState extends AuthState{
  final String successMessage;
  SuccessState({required this.successMessage});
}

final class ErrorState extends AuthState{
  final String errorMessage;

  ErrorState({required this.errorMessage});
}