part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class SuccessGettingUserCurrentLocation extends LocationState{}

final class ErrorGettingUserCurrentLocation extends LocationState {
  final String errorMessage;

  ErrorGettingUserCurrentLocation({required this.errorMessage});
}


final class SuccessGettingUserLocation extends LocationState {}

final class ErrorGettingUserLocation extends LocationState {
  final String errorMessage;

  ErrorGettingUserLocation({required this.errorMessage});
}


final class SuccessGettingReadableLocation extends LocationState {}

final class ErrorGettingReadableLocation  extends LocationState {
  final String errorMessage;

  ErrorGettingReadableLocation({required this.errorMessage});
}
