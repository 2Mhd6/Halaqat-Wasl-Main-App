import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:halaqat_wasl_main_app/data/hospitals_data.dart';
import 'package:halaqat_wasl_main_app/extensions/nav.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/model/hospital_model/hospital_model.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/home/request_bloc/request_bloc.dart';

class HospitalBottomSheet extends StatelessWidget {
  const HospitalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

    final requestBloc = context.read<RequestBloc>();
    final closeHospitals = GetIt.I.get<HospitalsData>().hospitals;
    log('${closeHospitals}');
    return SizedBox(
      height: context.getHeight(multiplied: 0.7),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr('select_hospital_bottom_sheet_home_screen.select_hospital'), style: AppTextStyle.sfProBold24),
              
              Gap.gapH32,
                
              ListView.separated(
                shrinkWrap: true,
                itemCount: closeHospitals.length,
                itemBuilder: (context, index){
                  return ListTile(
                    onTap: () {
                      
                      requestBloc.selectedHospital = closeHospitals[index];
                      
                      requestBloc.add(GettingHospitalRequest());
                      
                      requestBloc.add(CheckIfAllFieldsAreFilled());
                      context.pop();
                    },
                    title: Text(closeHospitals[index].hospitalName, style: AppTextStyle.sfPro60016,),
                  );
                },
                separatorBuilder: (context, index) {
                  return Column(
                    children: [
                      Gap.gapH16,
                      Divider(color: Colors.grey,),
              
                      if(index == closeHospitals.length)
                      Gap.gapH80
              
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}



// --- For Testing Only 
// final List<HospitalModel> hospitalsInRiyadh = [
//   // North Riyadh
//   HospitalModel(
//     hospitalId: '1',
//     name: 'King Abdullah Bin Abdulaziz University Hospital',
//     hospitalLat: 24.774252,
//     hospitalLong: 46.729566,
//   ),
//   HospitalModel(
//     hospitalId: '2',
//     name: 'Dr. Sulaiman Al Habib Hospital - Al Takhassusi',
//     hospitalLat: 24.809950,
//     hospitalLong: 46.653049,
//   ),

//   // Middle Riyadh
//   HospitalModel(
//     hospitalId: '3',
//     name: 'King Faisal Specialist Hospital & Research Centre',
//     hospitalLat: 24.690089,
//     hospitalLong: 46.679340,
//   ),
//   HospitalModel(
//     hospitalId: '4',
//     name: 'King Saud Medical City',
//     hospitalLat: 24.644111,
//     hospitalLong: 46.713081,
//   ),

//   // South Riyadh
//   HospitalModel(
//     hospitalId: '5',
//     name: 'Al Imam Medical Complex',
//     hospitalLat: 24.573308,
//     hospitalLong: 46.734055,
//   ),
//   HospitalModel(
//     hospitalId: '6',
//     name: 'Al Mamlaka Hospital',
//     hospitalLat: 24.597202,
//     hospitalLong: 46.726781,
//   ),
// ];
