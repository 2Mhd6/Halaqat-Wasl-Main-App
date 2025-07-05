part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class TogglePasswordViabilityEvent extends AuthEvent{}

final class SelectedGenderEvent extends AuthEvent{
  final int genderIndex;

  SelectedGenderEvent({required this.genderIndex});
}

final class SignUpEvent extends AuthEvent{}

final class LogInEvent extends AuthEvent {}
