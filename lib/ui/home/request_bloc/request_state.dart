part of 'request_bloc.dart';

@immutable
sealed class RequestState {}

final class RequestInitial extends RequestState {}

final class SuccessRequestState extends RequestState{}

final class FailedSendingRequestState extends RequestState {
  final String errorMessage;

  FailedSendingRequestState({required this.errorMessage});
}

final class AllFieldsAreFilledSuccessfully extends RequestState{}