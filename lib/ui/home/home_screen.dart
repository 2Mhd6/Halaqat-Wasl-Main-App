import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:halaqat_wasl_main_app/data/user_data.dart';
import 'package:halaqat_wasl_main_app/extensions/nav.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/app_custom_button.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/home/location_bloc/location_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/home/map_screen.dart';
import 'package:halaqat_wasl_main_app/ui/home/request_bloc/request_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/home/widgets/date_and_time_picker.dart';
import 'package:halaqat_wasl_main_app/ui/home/widgets/hospital_bottom_sheet.dart';
import 'package:halaqat_wasl_main_app/ui/home/widgets/request_input.dart';
import 'package:halaqat_wasl_main_app/ui/home/widgets/special_need_request.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LocationBloc()..add(GettingCurrentUserLocationEvent()),
        ),
        BlocProvider(create: (context) => RequestBloc()),
      ],
      child: BlocBuilder<RequestBloc, RequestState>(
        builder: (context, state) {
          return Builder(
            builder: (context) {

              final locationBloc = context.read<LocationBloc>();
              final requestBloc = context.read<RequestBloc>();
              final userData = GetIt.I.get<UserData>().user;
              final firstSecondName = '${userData?.fullName.split(' ')[0]} ${userData?.fullName.split(' ')[1]}';

              return Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('home_screen.hello'),
                            style: AppTextStyle.sfPro60016,
                          ),
                          Text(
                            '${firstSecondName} 👋',
                            style: AppTextStyle.sfPro60024,
                          ),

                          Gap.gapH56,

                          RequestInput(
                            label: requestBloc.formattedDate == null
                                ? tr('home_screen.pickup_date_and_time')
                                : requestBloc.formattedDate!,
                            iconPath: 'assets/home/calender.svg',
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return BlocProvider.value(
                                    value: requestBloc,
                                    child: ShowDataAndTimePicker(),
                                  );
                                },
                              );
                            },
                          ),

                          Gap.gapH32,

                          RequestInput(
                            label: requestBloc.readableLocation == null
                                ? tr('home_screen.current_location')
                                : requestBloc.readableLocation!,
                            iconPath: 'assets/home/location.svg',
                            onPressed: () {
                              context.moveTo(
                                context: context,
                                screen: MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(value: requestBloc),
                                    BlocProvider.value(value: locationBloc),
                                  ],
                                  child: MapScreen(),
                                ),
                              );
                            },
                          ),

                          Gap.gapH32,

                          RequestInput(
                            label: requestBloc.selectedHospital == null
                                ? tr('home_screen.select_hospital')
                                : requestBloc.selectedHospital!.name,
                            iconPath: requestBloc.selectedHospital == null
                                ? 'assets/home/arrow.svg'
                                : '',
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return BlocProvider.value(
                                    value: requestBloc,
                                    child: HospitalBottomSheet(),
                                  );
                                },
                              );
                            },
                          ),

                          Gap.gapH32,

                          SpecialNeedRequest(
                            notesController: requestBloc.notesController,
                          ),

                          Gap.gapH40,

                          AppCustomButton(
                            label: 'Place Order',
                            buttonColor: AppColors.primaryAppColor,
                            width: context.getWidth(),
                            height: context.getHeight(multiplied: 0.055),
                            onPressed: requestBloc.isFilledAllFields
                                ? () {
                                    requestBloc.add(AddNewRequestEvent());
                                  }
                                : null,
                          ),

                          Gap.gapH56,

                          SizedBox(
                            width: context.getWidth(),
                            child: Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/home/car.svg'),
                                Text(
                                  tr('home_screen.no_ride_request'),
                                  style:
                                      AppTextStyle.sfPro60014SecondaryTextColor,
                                ),
                              ],
                            ),
                          ),

                          Gap.gapH56,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
