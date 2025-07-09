import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halaqat_wasl_main_app/extensions/nav.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/app_custom_button.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/ui/home/location_bloc/location_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/home/request_bloc/request_bloc.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final locationBloc = context.read<LocationBloc>();
        final requestBloc = context.read<RequestBloc>();

        return Scaffold(
          resizeToAvoidBottomInset: false, // prevent automatic resizing
          body: Stack(
            children: [
              Stack(
                children: [
                  GoogleMap(
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    initialCameraPosition: locationBloc.cameraPosition!,
                    onCameraMove: (position) => locationBloc.selectedLocation = position.target,
                    onCameraIdle: () => locationBloc.add(GettingUserLocationEvent(userLocation: locationBloc.selectedLocation!)),
                    onMapCreated: (controller) => locationBloc.googleMapController = controller,
                  ),
              
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Icon(Icons.push_pin_rounded, color: Colors.red),
                  ),
                ],
              ),

              Positioned(
                right: 10,
                bottom: 110,
                child: TextButton(
                  onPressed: (){
                   //  locationBloc.googleMapController?.animateCamera(CameraUpdate.newLatLng(locationBloc.userLocation!));
                   locationBloc.add(GettingCurrentUserLocationEvent());
                   
                  }, 
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.location_on_outlined,size: 30,color: AppColors.primaryAppColor,),
                  )
                )
              ),

              Positioned(
                bottom: context.getHeight(multiplied: 0.04),
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: AppCustomButton(
                    label: tr('google_map_screen.confirm_location'),
                    buttonColor: AppColors.primaryAppColor,
                    width: context.getWidth(),
                    height: context.getHeight(multiplied: 0.055),
                    onPressed: () async {
                      
                      locationBloc.add(GettingReadableLocationEvent(userLocation: locationBloc.userLocation!));

                      // -- Why do I need some delay ?
                      // For making the location field with the data and make the user location var in location bloc has the new value
                      // await Future.delayed(Duration(milliseconds: 600));

                      requestBloc.userLocation = await locationBloc.passUserLocation();
                      requestBloc.readableLocation = await locationBloc.passReadableLocation();

                      requestBloc.add(OpenNextFieldEvent(currentFieldIndex: 2));
                      requestBloc.add(GettingUserLocationToDetermineHospitals(userLocation: locationBloc.userLocation!));
                      
                      // requestBloc.add(CheckIfAllFieldsAreFilled());
                      if(context.mounted){
                        context.pop();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
