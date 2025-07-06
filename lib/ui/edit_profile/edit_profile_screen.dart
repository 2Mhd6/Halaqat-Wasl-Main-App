import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      create: (context) =>
          EditProfileBloc()..add(EditProfileDataLoadRequested()),
      child: Scaffold(
        body: SafeArea(
          child: Builder(
            builder: (context) {
              final bloc = context.read<EditProfileBloc>();
              return BlocListener<EditProfileBloc, EditProfileState>(
                //bottom sheet
                listener: (context, state) {
                  if (state.isSaved) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return EditProfileSuccessSheet();
                      },
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        context.read<EditProfileBloc>().add(
                          ResetIsSavedState(),
                        );
                        Navigator.of(context).pop();
                      }
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
                                      Form(
                                        key: bloc.detailsFormKey,
                                        child: Column(
                                          children: [
                                            EditProfileField(
                                              controller: bloc.nameController,
                                              icon: 'assets/icons/account.png',
                                            ),
                                            EditProfileField(
                                              controller: bloc.emailController,
                                              icon: 'assets/icons/email.png',
                                            ),
                                            EditProfileField(
                                              controller: bloc.phoneController,
                                              icon: 'assets/icons/call.png',
                                              keyboardType: TextInputType.phone,
                                              inputFormatters: [
                                                // Prevent deleting the country code
                                                TextInputFormatter.withFunction((
                                                  oldValue,
                                                  newValue,
                                                ) {
                                                  if (!newValue.text.startsWith(
                                                    bloc.countryCode,
                                                  )) {
                                                    return oldValue;
                                                  }
                                            
                                                  // Part after the country code (phone number)
                                                  final afterCode = newValue.text
                                                      .substring(
                                                        bloc.countryCode.length,
                                                      );
                                            
                                                  // Ensure only digits are entered after the country code
                                                  if (afterCode.contains(
                                                    RegExp(r'[^\d]'),
                                                  )) {
                                                    return oldValue;
                                                  }
                                            
                                                  return newValue;
                                                }),
                                              ],
                                            
                                              validator: (value) {
                                                if (value!.contains('+966')) {
                                                  final phoneNumber = value
                                                      .replaceAll('+966', '');
                                                  if (phoneNumber.length != 9) {
                                                    return tr(
                                                      'edit_profile_screen.phone_number_invalid',
                                                    );
                                                  }
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        tr(
                                          'edit_profile_screen.change_password',
                                        ),
                                        style: AppTextStyle.sfProBold20,
                                        textAlign: TextAlign.center,
                                      ),

                                      // Fields to edit current password, new password, confirm password
                                      Form(
                                        key: bloc.passwordFormKey,
                                        child: Column(
                                          children: [
                                            BlocSelector<
                                              EditProfileBloc,
                                              EditProfileState,
                                              bool
                                            >(
                                              selector: (state) => state
                                                  .currentPasswordObscureText,
                                              builder: (context, state) => EditProfileField(
                                                controller: bloc
                                                    .currentPasswordController,
                                                hintText: tr(
                                                  'edit_profile_screen.current_password',
                                                ),
                                                obsecureText: state,
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    state
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: AppColors
                                                        .primaryButtonColor,
                                                  ),
                                                  onPressed: () {
                                                    // Toggle password visibility
                                                    bloc.add(
                                                      ToggleCurrentPasswordVisibility(),
                                                    );
                                                  },
                                                ),
                                                validator: (value) =>
                                                    value == null ||
                                                        value.isEmpty
                                                    ? tr(
                                                        'edit_profile_screen.current_password_required',
                                                      )
                                                    : null,
                                              ),
                                            ),
                                            BlocSelector<
                                              EditProfileBloc,
                                              EditProfileState,
                                              bool
                                            >(
                                              selector: (state) =>
                                                  state.newPasswordObscureText,

                                              builder: (context, state) {
                                                return EditProfileField(
                                                  controller:
                                                      bloc.newPassordController,
                                                  hintText: tr(
                                                    'edit_profile_screen.new_password',
                                                  ),
                                                  obsecureText: state,
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      state
                                                          ? Icons.visibility
                                                          : Icons
                                                                .visibility_off,
                                                      color: AppColors
                                                          .primaryButtonColor,
                                                    ),
                                                    onPressed: () {
                                                      // Toggle password visibility
                                                      bloc.add(
                                                        ToggleNewPasswordVisibility(),
                                                      );
                                                    },
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return tr(
                                                        'edit_profile_screen.new_password_required',
                                                      );
                                                    }
                                                    if (value.length < 6) {
                                                      return tr(
                                                        'edit_profile_screen.password_too_short',
                                                      );
                                                    }
                                                    return null;
                                                  },
                                                );
                                              },
                                            ),
                                            BlocSelector<
                                              EditProfileBloc,
                                              EditProfileState,
                                              bool
                                            >(
                                              selector: (state) => state
                                                  .confirmNewPasswordObscureText,

                                              builder: (context, state) {
                                                return EditProfileField(
                                                  controller: bloc
                                                      .confirmNewPasswordController,
                                                  hintText: tr(
                                                    'edit_profile_screen.confirm_password',
                                                  ),
                                                  obsecureText: state,
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      state
                                                          ? Icons.visibility
                                                          : Icons
                                                                .visibility_off,
                                                      color: AppColors
                                                          .primaryButtonColor,
                                                    ),
                                                    onPressed: () {
                                                      // Toggle password visibility
                                                      bloc.add(
                                                        ToggleConfirmNewPasswordVisibility(),
                                                      );
                                                    },
                                                  ),

                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return tr(
                                                        'edit_profile_screen.confirm_password_required',
                                                      );
                                                    }
                                                    if (value !=
                                                        bloc
                                                            .newPassordController
                                                            .text) {
                                                      return tr(
                                                        'edit_profile_screen.passwords_not_match',
                                                      );
                                                    }
                                                    return null;
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Error message
                                BlocSelector<
                                  EditProfileBloc,
                                  EditProfileState,
                                  String?
                                >(
                                  selector: (state) => state.errorMessage,
                                  builder: (context, errorMessage) {
                                    return errorMessage != null
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              errorMessage,
                                              style: AppTextStyle.sfPro16
                                                  .copyWith(color: Colors.red),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : SizedBox.shrink();
                                  },
                                ),
                                // Save button
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 16.0,
                                    left: 8.0,
                                    right: 8.0,
                                  ),
                                  child:
                                      BlocSelector<
                                        EditProfileBloc,
                                        EditProfileState,
                                        bool
                                      >(
                                        selector: (state) => state.isLoading,
                                        builder: (context, isLoading) =>
                                            isLoading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : ElevatedButton(
                                                onPressed: () {
                                                  //save event
                                                  bloc.add(
                                                    SaveProfileRequested(),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColors
                                                      .primaryButtonColor,
                                                  foregroundColor: Colors.white,
                                                  padding: EdgeInsets.all(16.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      tr(
                                                        'edit_profile_screen.save',
                                                      ),
                                                      style: AppTextStyle
                                                          .sfProBold16,
                                                    ),
                                                  ],
                                                ),
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
