import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halaqat_wasl_main_app/services/user_location.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  LatLng? userLocation; 
  LatLng? selectedLocation;
  String? readableLocation;

  CameraPosition? cameraPosition;  
  GoogleMapController? googleMapController;


  LocationBloc() : super(LocationInitial()) {
    
    on<LocationEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GettingCurrentUserLocationEvent>(gettingCurrentUserLocation);

    on<GettingUserLocationEvent>(gettingUserLocation);

    on<GettingReadableLocationEvent>(gettingReadableLocation);
  }

  FutureOr<void> gettingCurrentUserLocation(GettingCurrentUserLocationEvent event, Emitter<LocationState> emit) async {

    try{

      final location = await UserLocation.determinePosition();
      userLocation = LatLng(location.latitude, location.longitude);
      cameraPosition = CameraPosition(
        target: userLocation!,
        zoom: 15
      );

      googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition!),
      );

      emit(SuccessGettingUserCurrentLocation());
    }catch(error){
      emit(ErrorGettingUserCurrentLocation(errorMessage: error.toString()));
    }
  }


    FutureOr<void> gettingUserLocation(GettingUserLocationEvent event, Emitter<LocationState> emit) async {

    try{

      final location = event.userLocation;
      userLocation = LatLng(location.latitude, location.longitude);

      emit(SuccessGettingUserCurrentLocation());
    }catch(error){
      emit(ErrorGettingUserCurrentLocation(errorMessage: error.toString()));
    }
  }

  FutureOr<void> gettingReadableLocation(GettingReadableLocationEvent event, Emitter<LocationState> emit) async {

    try{

      final userLocation = event.userLocation;
      final List<Placemark> placemarks = await placemarkFromCoordinates(userLocation.latitude, userLocation.longitude);
      readableLocation = '${placemarks[0].locality == null || placemarks[0].locality!.isEmpty? '' : '${placemarks[0].locality}'} ${(placemarks[0].subLocality == null || placemarks[0].subLocality!.isEmpty) ? '' : ', ${placemarks[0].subLocality}'}';

      emit(SuccessGettingReadableLocation());
    }catch(error){
      emit(ErrorGettingReadableLocation(errorMessage: error.toString()));
    }
  }

  // -- For Passing data to request BLoC
  Future<String> passReadableLocation() async {
    
    // You might ask why I used Future.delayed here.
    // Simply put, there's a slight delay before the readable location stores its new value.
    // To prevent the app from crashing, I added a short wait.
    await Future.delayed(Duration(milliseconds: 800));
    return readableLocation!;
  }

  Future<LatLng> passUserLocation() async {
    await Future.delayed(Duration(milliseconds: 800));
    return userLocation!;
  }
}

