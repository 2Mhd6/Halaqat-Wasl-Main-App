import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/model/request_model/request_model.dart';
import 'package:halaqat_wasl_main_app/model/complaint_model/complaint_model.dart';
import 'package:halaqat_wasl_main_app/repo/request/complaint_repo.dart';
import 'package:halaqat_wasl_main_app/repo/request/request_repo.dart';

part 'request_details_event.dart';
part 'request_details_state.dart';

class RequestDetailsBloc
    extends Bloc<RequestDetailsEvent, RequestDetailsState> {
  RequestModel? request;
  ComplaintModel? complaint;

  RequestDetailsBloc() : super(RequestInitial()) {
    on<LoadRequestDetails>(_onLoadRequestDetails);
    on<StartWritingComplaint>(_onStartWritingComplaint);
    on<WritingComplaintEmpty>(_onWritingComplaintEmpty);
    on<SubmitComplaint>(_onSubmitComplaint);
    // on<WaitForResponse>((event, emit) => emit(ComplaintWaitingResponse()));
    // on<ReceiveResponse>((event, emit) => emit(ComplaintResponded()));
    on<CancelRequest>(_onCancelRequest);
  }
  //Load the RequestModel and ComplaintModel data, and specify the appropriate initial status to display on the user interface.
  void _onLoadRequestDetails(
    LoadRequestDetails event,
    Emitter<RequestDetailsState> emit,
  ) {
    request = event.request;
    complaint = event.complaint;

    if (complaint != null && complaint!.response.isNotEmpty) {
      //Complaint Response Available -> Send Status ComplaintResponded
      emit(ComplaintResponded());
    } else if (complaint != null && complaint!.response.isEmpty) {
      //The user submitted a complaint, but no response yet -> We send the ComplaintWaitingResponse() status.
      emit(ComplaintWaitingResponse());
    } else {
      emit(
        ComplaintWritingButEmpty(),
      ); //What complaint was written before -> We send the status ComplaintWritingButEmpty()
    }
  }

  //Called when the user starts typing inside the complaint box until the button color changes
  void _onStartWritingComplaint(
    StartWritingComplaint event,
    Emitter<RequestDetailsState> emit,
  ) {
    emit(ComplaintWriting());
  }

  //If the user deletes all the text inside the complaint box, the button will be disabled.
  void _onWritingComplaintEmpty(
    WritingComplaintEmpty event,
    Emitter<RequestDetailsState> emit,
  ) {
    emit(ComplaintWritingButEmpty());
  }

  //When you press the "Submit Complaint" button -> the status changes to ComplaintSubmitted temporarily, waiting (until the complaint is sent to Supabase), then the status changes to ComplaintWaitingResponse
  void _onSubmitComplaint(
    SubmitComplaint event,
    Emitter<RequestDetailsState> emit,
  ) async {
    // Send the Complaint to Supabase by event.complaintText
    emit(ComplaintSubmitted());

    await ComplaintRepo.insertComplaintAndLinkToRequest(
      requestId: request!.requestId,
      complaintText: event.complaintText,
      userId: request!.userId,
      hospitalId: request!.hospitalId,
      driverId: request!.driverId,
      charityId: request!.charityId,
    );

    emit(ComplaintWaitingResponse());
  }

  //When the user clicks the "Cancel" button in the pending request state -> the state inside the request object changes to 'cancelled', sending the new state RequestCancelled
  void _onCancelRequest(
    CancelRequest event,
    Emitter<RequestDetailsState> emit,
  ) async {
    await RequestRepo.cancelRequest(request!.requestId); //  Update to Supabase
    request!.status = 'cancelled'; //Update locally
    emit(RequestCancelled());
  }
}
