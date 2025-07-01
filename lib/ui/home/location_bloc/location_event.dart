part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

final class GettingCurrentUserLocationEvent extends LocationEvent {}

final class GettingUserLocationEvent extends LocationEvent {
  final LatLng userLocation;

  GettingUserLocationEvent({required this.userLocation});
}

final class GettingReadableLocationEvent extends LocationEvent{

  final LatLng userLocation;

  GettingReadableLocationEvent({required this.userLocation});
  
}
