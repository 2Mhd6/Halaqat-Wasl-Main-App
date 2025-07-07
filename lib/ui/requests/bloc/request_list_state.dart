part of 'request_list_bloc.dart';

@immutable
abstract class RequestListState {}

class RequestListInitial extends RequestListState {}

class RequestListLoading extends RequestListState {}

class RequestListLoaded extends RequestListState {
  final List<RequestModel> requests;

  RequestListLoaded({required this.requests});
}

class RequestListError extends RequestListState {
  final String message;

  RequestListError(this.message);
}
