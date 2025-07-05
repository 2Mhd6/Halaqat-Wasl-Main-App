import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';

// ignore: must_be_immutable
class AuthTextFieldWithLabel extends StatelessWidget {
  AuthTextFieldWithLabel({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.isShowPassword = false,
    this.isPhoneNumber = false,
    this.onPressedToShowPasswordViability,
     this.onValidate,
  });

  final String label;
  final TextEditingController controller;
  final bool isPassword;
  bool isShowPassword;
  bool isPhoneNumber;
  final void Function()? onPressedToShowPasswordViability;
  final String? Function(String? value)? onValidate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Text(label, style: AppTextStyle.sfProW60016),

        SizedBox(
          width: context.getWidth(),
          height: context.getHeight(multiplied: 0.08),
          child:  Row(
            spacing:  isPhoneNumber ? 8 : 0,
            children: [

              if(isPhoneNumber)
              Expanded(
                flex: 0,
                child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 22),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderColor),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        // BoxShadow(
                        //   color: Color.fromRGBO(0, 0, 0, 0.25),
                        //   offset: Offset(0, 2),
                        //   blurRadius: 2,
                        // ),
                      ],
                    ),
                    child: Row(
                      spacing: 6,
                      children: [
                        Image.asset('assets/auth/saudi_arabia.png'),
                
                        Text('+966'),
                      ],
                    ),
                  ),
              ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // -- It cause an glitch in the ui when I have a validator message
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Color.fromRGBO(0, 0, 0, 0.25),
                    //     offset: Offset(0, 2),
                    //     blurRadius: 2,
                    //     ),
                    // ],
                  ),
                  child: TextFormField(
                    controller: controller,
                    cursorHeight: 20,
                    enableSuggestions: !isPassword, 
                    autocorrect: !isPassword,    
                    cursorColor: Colors.black54,
                    style: TextStyle(fontSize: 16, fontFamily: 'SFPro'),
                    obscureText: isPassword ? !isShowPassword : false,
                    keyboardType: isPassword ? TextInputType.visiblePassword : (isPhoneNumber ? TextInputType.number : TextInputType.text),
                    inputFormatters: isPhoneNumber ? [LengthLimitingTextInputFormatter(9)] : null,
                    validator: onValidate,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      errorMaxLines: 1,
                      helperText: ' ',
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      errorStyle: TextStyle(color: AppColors.errorColor),
                      suffixIcon: isPassword ? IconButton(icon: Icon(isShowPassword ? Icons.visibility : Icons.visibility_off),onPressed: onPressedToShowPasswordViability) : null,
                      border: OutlineInputBorder(
                        
                        borderSide: BorderSide(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color.fromARGB(255, 238, 100, 90),),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
