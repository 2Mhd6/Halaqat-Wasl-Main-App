import 'dart:developer';

import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halaqat_wasl_main_app/extensions/nav.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/helpers/format_date_time.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/app_custom_button.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/home/request_bloc/request_bloc.dart';

class ShowDataAndTimePicker extends StatelessWidget {
  const ShowDataAndTimePicker({super.key});

  @override
  Widget build(BuildContext context) {

    final startDate = DateTime.now().add(Duration(days: 1));
    const totalDays = 7;
    final allDates = List<DateTime>.generate(totalDays,(i) => startDate.add(Duration(days: i)));
    final inactiveDates = allDates.where((d) => d.weekday == DateTime.friday || d.weekday == DateTime.saturday,).toList();


    DateTime date = DateTime.now().add(Duration(days: 1)); 
    TimeOfDay selectedTime = TimeOfDay(hour: 8, minute: 0);

    final requestBloc = context.read<RequestBloc>();

    return  Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.appBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: context.getHeight(multiplied: 0.39),
        width: context.getWidth(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr('date_and_time_dialog.choose_date_and_time'),
                  style: AppTextStyle.sfPro60016,
                ),

                SvgPicture.asset('assets/home/Calendar.svg'),
              ],
            ),

            Gap.gapH24,

            DatePicker(
              DateTime.now().add(Duration(days: 1)),
              initialSelectedDate: DateTime.now().add(Duration(days: 1)),
              height: 88,
              daysCount: 7,
              inactiveDates: inactiveDates,
              selectionColor: AppColors.primaryAppColor,
              onDateChange: (selectedDate) {
                date = selectedDate;
              },
            ),

            Gap.gapH8,

            Text(tr('date_and_time_dialog.schedule_notice')),

            Gap.gapH24,

            CupertinoTimePickerButton(
              minuteInterval: 30,
              minimumTime: TimeOfDay(hour: 8, minute: 00),
              maximumTime: TimeOfDay(hour: 18, minute: 00),
              initialTime: TimeOfDay(hour: 8, minute: 0),
              mainColor: Colors.black,
              buttonDecoration: PickerButtonDecoration(
                textStyle: TextStyle(fontSize: 30, color: Colors.black),
              ),
              
              onTimeChanged: (time) {
                selectedTime = time;
              },
            ),

            Gap.gapH40,

            AppCustomButton(
              label: tr('date_and_time_dialog.continue'),
              buttonColor: AppColors.primaryAppColor,
              width: context.getWidth(),
              height: context.getHeight(multiplied: 0.055),
              onPressed: () {
                final selectedDate = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  selectedTime.hour,
                  selectedTime.minute
                );

                log('----------');

                requestBloc.requestDate = selectedDate;
                log(requestBloc.requestDate!.toString());

                requestBloc.formattedDate = formatDateTime(requestBloc.requestDate!);

                requestBloc.add(GettingDateRequest());

                requestBloc.add(CheckIfAllFieldsAreFilled());

                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}