import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halaqat_wasl_main_app/data/user_data.dart';
import 'package:halaqat_wasl_main_app/model/hospital_model/hospital_model.dart';
import 'package:halaqat_wasl_main_app/model/request_model/request_model.dart';
import 'package:halaqat_wasl_main_app/repo/request/request_repo.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  DateTime? requestDate;
  String? formattedDate;
  LatLng? userLocation;
  String? readableLocation;
  HospitalModel? selectedHospital;
  TextEditingController notesController = TextEditingController();
  bool isFilledAllFields = false;

  RequestBloc() : super(RequestInitial()) {
    on<RequestEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GettingDateRequest>((event, emit) => emit(SuccessRequestState()));
    on<GettingHospitalRequest>((event, emit) => emit(SuccessRequestState()));
    on<CheckIfAllFieldsAreFilled>(checkIfAllFieldsAreFilled);
    on<AddNewRequestEvent>(addNewRequest);
  }

  FutureOr<void> checkIfAllFieldsAreFilled(
    CheckIfAllFieldsAreFilled event,
    Emitter<RequestState> emit,
  ) {
    if (requestDate == null ||
        userLocation == null ||
        selectedHospital == null) {
      isFilledAllFields = false;
      emit(
        FailedSendingRequestState(
          errorMessage: 'Fill all the fields, to send your request',
        ),
      );
      return null;
    }

    isFilledAllFields = true;

    emit(AllFieldsAreFilledSuccessfully());
  }

  FutureOr<void> addNewRequest(
    AddNewRequestEvent event,
    Emitter<RequestState> emit,
  ) async {
    if (!isFilledAllFields) {
      emit(
        FailedSendingRequestState(
          errorMessage: 'Fill all the fields, to send your request',
        ),
      );
      return null;
    }

    final user = GetIt.I.get<UserData>().user;
    log(requestDate.toString());

    // The static Driver Id for testing purpose
    final request = RequestModel(
      requestId: Uuid().v4(),
      userId: user!.userId,
      charityId: null,
      hospitalId: selectedHospital!.hospitalId,
      complaintId: null,
      driverId: 'cfbd7c7a-6124-4353-b8e6-fb660c733e4a',
      pickupLat: userLocation!.latitude,
      pickupLong: userLocation!.longitude,
      destinationLat: selectedHospital!.hospitalLat,
      destinationLong: selectedHospital!.hospitalLong,
      note: notesController.text.isEmpty ? null : notesController.text,
      requestDate: requestDate!,
      status: 'pending',
    );

    try {
      await RequestRepo.insertRequestIntoDB(request: request);

      log('Inserting request to DB ');

      clear();
      emit(SuccessRequestState());
    } catch (error) {
      log('Failed to insert to DB - ${error.toString()}');
      emit(FailedSendingRequestState(errorMessage: error.toString()));
    }
  }

  // -- Clearing Fields
  void clear() {
    requestDate = null;
    formattedDate = null;
    userLocation = null;
    readableLocation = null;
    selectedHospital = null;
    isFilledAllFields = false;
    notesController.clear();
  }

  @override
  Future<void> close() {
    notesController.dispose();
    return super.close();
  }
}
