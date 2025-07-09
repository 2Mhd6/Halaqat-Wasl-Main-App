import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halaqat_wasl_main_app/data/hospitals_data.dart';
import 'package:halaqat_wasl_main_app/data/user_data.dart';
import 'package:halaqat_wasl_main_app/helpers/readable_location.dart';
import 'package:halaqat_wasl_main_app/model/hospital_model/hospital_model.dart';
import 'package:halaqat_wasl_main_app/model/request_model/request_model.dart';
import 'package:halaqat_wasl_main_app/repo/hospital/hospital_repo.dart';
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
  bool isFirstField = false;
  bool isSecondField = false;
  bool isThirdField = false;
  bool isFilledAllFields = false;

  RequestBloc() : super(RequestInitial()) {
    on<RequestEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GettingDateRequest>((event, emit) => emit(SuccessRequestState()));
    on<GettingHospitalRequest>((event, emit) => emit(SuccessRequestState()));
    on<OpenNextFieldEvent>(openNextField);
    on<CheckIfAllFieldsAreFilled>(checkIfAllFieldsAreFilled);
    on<GettingUserLocationToDetermineHospitals>(gettingUserLocationToDetermineHospitals);
    on<AddNewRequestEvent>(addNewRequest);
  }

  FutureOr<void> openNextField(OpenNextFieldEvent event, Emitter<RequestState> emit) {
    final currentIndex = event.currentFieldIndex;

    switch (currentIndex) {
      case 1:
        isSecondField = true;
        emit(SuccessOpenNextField());
        break;
      case 2:
        isThirdField = true;
        emit(SuccessOpenNextField());
    }
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

  FutureOr<void> gettingUserLocationToDetermineHospitals(GettingUserLocationToDetermineHospitals event, Emitter<RequestState> emit) async {

    final userLocation = event.userLocation;


    try{
      final hospitals = await HospitalRepo.getAllHospital();
      log('--9--$hospitals');
      final closeHospitals = filterHospitalsUpToTenKM(userLocation: userLocation, hospitals: hospitals);
      log('$hospitals');
      GetIt.I.get<HospitalsData>().hospitals = closeHospitals;
      emit(DeterminingHospitalsState());
    }catch(error){
      log(error.toString());
      emit(ErrorState(errorMessage: error.toString()));
    }
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

    final pickUpReadableAddress = await ReadableLocation.readableAddress(lat: userLocation!.latitude, long: userLocation!.longitude);
    final destinationReadableAddress = await ReadableLocation.readableAddress(lat: selectedHospital!.hospitalLat, long: selectedHospital!.hospitalLong);
    
    log(requestDate.toString());

    // The static Driver Id for testing purpose
    // '67fe4cbf-3a3d-454b-aa87-6c026709578e'
    final request = RequestModel(
      requestId: Uuid().v4(),
      userId: user!.userId,
      charityId: null,
      hospitalId: selectedHospital!.hospitalId,
      complaintId: null,
      driverId: null,
      pickupLat: userLocation!.latitude,
      pickupLong: userLocation!.longitude,
      pickUpReadableAddress: pickUpReadableAddress  ,
      destinationLat: selectedHospital!.hospitalLat,
      destinationLong: selectedHospital!.hospitalLong,
      destinationReadableAddress: destinationReadableAddress,
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


  List<HospitalModel> filterHospitalsUpToTenKM({ required LatLng userLocation, required List<HospitalModel> hospitals})  {


    return hospitals.where((hospital) {
      double distanceInMeters = Geolocator.distanceBetween(
        userLocation.latitude,
        userLocation.longitude,
        hospital.hospitalLat,
        hospital.hospitalLong
      );

      double distanceInKm = distanceInMeters / 1000;
      return distanceInKm <= 7;
    }).toList();
  }
}
