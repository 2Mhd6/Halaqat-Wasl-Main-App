part of 'request_bloc.dart';

@immutable
sealed class RequestState {}

final class RequestInitial extends RequestState {}

final class SuccessRequestState extends RequestState{}

final class ErrorState extends RequestState{
  final String errorMessage;
  ErrorState({required this.errorMessage});
}

final class FailedSendingRequestState extends RequestState {
  final String errorMessage;

  FailedSendingRequestState({required this.errorMessage});
}

final class SuccessOpenNextField extends RequestState{}

final class AllFieldsAreFilledSuccessfully extends RequestState{}

final class DeterminingHospitalsState extends RequestState{}

