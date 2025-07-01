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
  // LatLng? tappedLocation;
  // Set<Marker>? markers;
  // Marker? marker;

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
      // print(placemarks[0].country);
      // print(placemarks[0].locality);
      // print(placemarks[0].subLocality);
      
      readableLocation = '${placemarks[0].locality == null ? '' : '${placemarks[0].locality}'} ${(placemarks[0].subLocality == null || placemarks[0].subLocality!.isEmpty) ? '' : ', ${placemarks[0].subLocality}'}';

      emit(SuccessGettingReadableLocation());
    }catch(error){
      emit(ErrorGettingReadableLocation(errorMessage: error.toString()));
    }
  }
}

