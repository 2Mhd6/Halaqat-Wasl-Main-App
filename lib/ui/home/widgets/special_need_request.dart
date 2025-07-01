import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';

class SpecialNeedRequest extends StatelessWidget {
  const SpecialNeedRequest({super.key, required this.notesController});

  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 4,
          children: [
            Text(tr('home_screen.additional_notes'), style: AppTextStyle.sfPro60014),
            Text(tr('home_screen.optional'), style: AppTextStyle.sfPro60014SecondaryTextColor)
          ],
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(53, 50, 215, 0.10),
                offset: Offset(2, 4),
                blurRadius: 8
              )
            ]
          ),

          child: TextField(
            controller: notesController,
            cursorHeight: 14,
            cursorColor: Colors.black,
            style: AppTextStyle.sfPro60014,
            maxLines: 3,
            maxLength: 160,
            keyboardType: TextInputType.multiline,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'^[ \t]')),
              FilteringTextInputFormatter.deny(RegExp(r'[\r\n]')),
            ],
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              counterText: '',
              hint: Text(tr('home_screen.additional_notes_filed'), style: AppTextStyle.sfPro60014SecondaryTextColor,),
              contentPadding: EdgeInsets.all(14),
              border: OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.transparent)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.transparent)),
              
            ),
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            onSubmitted: (value) => FocusScope.of(context).unfocus(),
          )
        )
      ],
    );
  }
}