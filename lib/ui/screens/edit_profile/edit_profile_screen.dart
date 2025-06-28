import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/edit_profile_success_sheet.dart';
import 'package:halaqat_wasl_main_app/theme/app_color.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/screens/edit_profile/widgets/edit_profile_field.dart';

import 'bloc/edit_profile_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileBloc>(
      create: (context) => EditProfileBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Builder(
            builder: (context) {
              final bloc = context.read<EditProfileBloc>();
              return BlocListener<EditProfileBloc, EditProfileState>(
                listener: (context, state) {
                  if(state is EditProfileData){
                    showModalBottomSheet(context: context, builder: (context){
                      return EditProfileSuccessSheet();
                    });
                  }
                },
                child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 16.0),
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/logo.png',
                                    height: 100,
                                    width: 150,
                                  ),
                                  Expanded(
                                    child: Card(
                                      color: Colors.white,
                                      margin: EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        top: 32.0,
                                        bottom: 64.0,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Edit Profile',
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyle.sfProBold24,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: ListView(
                                                primary: false,
                                                children: [
                                                  EditProfileField(
                                                    controller: bloc.nameController,
                                                    initialValue: 'Mohammed Ali Alharbi',
                                                    icon: 'assets/icons/account.png',
                                                  ),
                                                  EditProfileField(
                                                    controller: bloc.emailController,
                                                    initialValue: 'Mohammed@gmail.com',
                                                    icon: 'assets/icons/email.png',
                                                  ),
                                                  EditProfileField(
                                                    controller: bloc.phoneController,
                                                    initialValue: '+966 561577821',
                                                    icon: 'assets/icons/call.png',
                                                  ),
                                                  Text(
                                                    'Change Password',
                                                    style: AppTextStyle.sfProBold20,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  EditProfileField(
                                                    controller:
                                                        bloc.currentPasswordController,
                                                    hintText: 'Current Password',
                                                  ),
                                                  EditProfileField(
                                                    controller: bloc.newPassordController,
                                                    hintText: 'New Password',
                                                  ),
                                                  EditProfileField(
                                                    controller:
                                                        bloc.confirmNewPasswordController,
                                                    hintText: 'Confirm New Password',
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                bottom: 16.0,
                                                left: 8.0,
                                                right: 8.0,
                                              ),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  bloc.add(SaveProfileRequested());
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColor.primaryButtonColor,
                                                  foregroundColor: Colors.white,
                                                  padding: EdgeInsets.all(16.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Save',
                                                      style: AppTextStyle.sfProBold16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
              );
            },
          ),
        ),
      ),
    );
  }
}
