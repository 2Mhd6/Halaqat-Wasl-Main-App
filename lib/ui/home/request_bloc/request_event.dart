part of 'request_bloc.dart';

@immutable
sealed class RequestEvent {}

final class GettingDateRequest extends RequestEvent{}

final class GettingHospitalRequest extends RequestEvent{}

final class CheckIfAllFieldsAreFilled extends RequestEvent{}

final class AddNewRequestEvent extends RequestEvent{}
