import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/edit_profile_success_sheet.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/edit_profile/widgets/edit_profile_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'bloc/edit_profile_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileBloc>(
      // Create EditProfileBloc to manage edit profile logic
      create: (context) => EditProfileBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Builder(
            builder: (context) {
              final bloc = context.read<EditProfileBloc>();
              return BlocListener<EditProfileBloc, EditProfileState>(
                // Listen for success state to show confirmation bottom sheet
                listener: (context, state) {
                  if (state is EditProfileData) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return EditProfileSuccessSheet();
                      },
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 16.0),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // App logo
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
                              // Page title "Edit Profile"
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        tr('edit_profile_screen.profile'),
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
                                    // Fields to edit name, email, and phone number
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
                                        tr(
                                          'edit_profile_screen.change_password',
                                        ),
                                        style: AppTextStyle.sfProBold20,
                                        textAlign: TextAlign.center,
                                      ),

                                      // Fields to edit current password, new password, confirm password
                                      EditProfileField(
                                        controller:
                                            bloc.currentPasswordController,
                                        hintText: tr(
                                          'edit_profile_screen.current_password',
                                        ),
                                      ),
                                      EditProfileField(
                                        controller: bloc.newPassordController,
                                        hintText: tr(
                                          'edit_profile_screen.new_password',
                                        ),
                                      ),
                                      EditProfileField(
                                        controller:
                                            bloc.confirmNewPasswordController,
                                        hintText: tr(
                                          'edit_profile_screen.confirm_password',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Save button
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 16.0,
                                    left: 8.0,
                                    right: 8.0,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                       // Send save event to Bloc
                                      bloc.add(SaveProfileRequested());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.primaryButtonColor,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.all(16.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          tr('edit_profile_screen.save'),
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
