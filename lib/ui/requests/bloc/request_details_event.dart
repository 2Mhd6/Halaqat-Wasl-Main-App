part of 'request_details_bloc.dart';

abstract class RequestDetailsEvent {}

class LoadRequestDetails extends RequestDetailsEvent {
  final RequestModel request;
  final ComplaintModel? complaint;

  LoadRequestDetails({required this.request, this.complaint});
}

class StartWritingComplaint extends RequestDetailsEvent {}

class WritingComplaintEmpty extends RequestDetailsEvent {}

class SubmitComplaint extends RequestDetailsEvent {
  final String complaintText;

  SubmitComplaint(this.complaintText);
}


class WaitForResponse extends RequestDetailsEvent {}

class ReceiveResponse extends RequestDetailsEvent {}

class CancelRequest extends RequestDetailsEvent {}
