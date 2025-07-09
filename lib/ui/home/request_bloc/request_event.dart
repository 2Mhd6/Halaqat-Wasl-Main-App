part of 'request_bloc.dart';

@immutable
sealed class RequestEvent {}

final class GettingDateRequest extends RequestEvent{}

final class GettingHospitalRequest extends RequestEvent{}

final class OpenNextFieldEvent extends RequestEvent{
  final int currentFieldIndex; 
  OpenNextFieldEvent({required this.currentFieldIndex});
}

final class CheckIfAllFieldsAreFilled extends RequestEvent{}

final class GettingUserLocationToDetermineHospitals extends RequestEvent{
  final LatLng userLocation;
  GettingUserLocationToDetermineHospitals({required this.userLocation});
}

final class AddNewRequestEvent extends RequestEvent{}
