part of 'request_details_bloc.dart';

abstract class RequestDetailsState {}

class RequestInitial extends RequestDetailsState {}

class ComplaintWriting extends RequestDetailsState {}

class ComplaintWritingButEmpty extends RequestDetailsState {}

class ComplaintSubmitted extends RequestDetailsState {}

class ComplaintWaitingResponse extends RequestDetailsState {}

class ComplaintResponded extends RequestDetailsState {}

class RequestCancelled extends RequestDetailsState {}
