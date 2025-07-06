import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:halaqat_wasl_main_app/data/user_data.dart';
import 'package:halaqat_wasl_main_app/repo/profile/edit_profile_repo.dart';
import 'package:halaqat_wasl_main_app/repo/user_operation/user_operation_repo.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  // Connects the form to validate or save data
  final passwordFormKey = GlobalKey<FormState>();
  final detailsFormKey = GlobalKey<FormState>();


  final countryCode  = '+966';
  // Text controllers to manage form fields values
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late final  TextEditingController phoneController;
  
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPassordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  EditProfileBloc() : super(EditProfileState()) {

    phoneController = TextEditingController();
    phoneController.addListener(() {
      // Prevent editing country code
      if (phoneController.selection.start < countryCode.length) {
        phoneController.selection = TextSelection.collapsed(
          offset: phoneController.text.length,
        );
      }
    });

    on<EditProfileDataLoadRequested>(_editProfileDataLoadRequested);
    on<SaveProfileRequested>(_saveProfileRequested);
    on<ResetIsSavedState>((event, emit) {
      emit(state.copyWith(isSaved: false));
    });
    on<ToggleCurrentPasswordVisibility>(_toggleCurrentPasswordVisibility);
    on<ToggleNewPasswordVisibility>((event, emit) {
      emit(
        state.copyWith(newPasswordObscureText: !state.newPasswordObscureText),
      );
    });
    on<ToggleConfirmNewPasswordVisibility>((event, emit) {
      emit(
        state.copyWith(
          confirmNewPasswordObscureText: !state.confirmNewPasswordObscureText,
        ),
      );
    });
  }

  // Handler for the load profile data event
  Future<void> _editProfileDataLoadRequested(
    EditProfileDataLoadRequested event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final userData = GetIt.I.get<UserData>().user;
    // Initialize text controllers
    nameController.text = userData?.fullName ?? '';
    emailController.text = userData?.email ?? '';
    phoneController.text = userData?.phoneNumber ?? '';
    //updated
    emit(state.copyWith(isLoading: false));
  }

  // Handler for the save profile event
  Future<void> _saveProfileRequested(
    SaveProfileRequested event,
    Emitter<EditProfileState> emit,
  ) async {
    final userData = GetIt.I.get<UserData>().user;
    // Read current values from the text controllers
    final name = nameController.text;
    final email = emailController.text;
    final phone = phoneController.text;
    final currentPassword = currentPasswordController.text;
    final newPassword = newPassordController.text;
    final confirmNewPassword = confirmNewPasswordController.text;

    // Validate the form fields
    if (userData!.email == email &&
        userData.fullName == name &&
        userData.phoneNumber == phone) {
    } else {
      if (!detailsFormKey.currentState!.validate()) {
        return;
      }

      emit(state.copyWith(isLoading: true, errorMessage: null));

      final newUserData = userData.copyWith(
        fullName: name,
        email: email,
        phoneNumber: phone,
      );
      
      final updated = await EditProfileRepo.updateUserDetailsInDB(
        user: newUserData,
      );
      // If update succeeds, refresh user data and emit success state;
      // If update fails, emit error state
      if (updated) {
        GetIt.I.get<UserData>().user =
            await UserOperationRepo.getUserDetailsFromDB();
        emit(state.copyWith(isLoading: false, isSaved: true));
      } else {
        emit(
          state.copyWith(
            errorMessage: 'Failed to update profile. Please try again.',
            isLoading: false,
          ),
        );
        return;
      }
    }

    // Check and update password if fields are not empty.
    if (currentPassword.isNotEmpty ||
        newPassword.isNotEmpty ||
        confirmNewPassword.isNotEmpty) {
      if (!passwordFormKey.currentState!.validate()) {
        return;
      }

      final isPasswordUpdated = await EditProfileRepo.updateUserPasswordInDB(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      emit(state.copyWith(isLoading: true, errorMessage: null));
      if (!isPasswordUpdated) {
        emit(
          state.copyWith(
            errorMessage: 'Failed to update password. Please try again.',
            isLoading: false,
          ),
        );
        return;

      } else {
        // Password updated successfully: reset fields and hide text
        currentPasswordController.clear();
        newPassordController.clear();
        confirmNewPasswordController.clear();
        emit(
          state.copyWith(
            isLoading: false,
            isSaved: true,
            currentPasswordObscureText: true,
            newPasswordObscureText: true,
            confirmNewPasswordObscureText: true,
          ),
        );
      }
    }
  }

  // Handler for toggling password visibility
  void _toggleCurrentPasswordVisibility(
    ToggleCurrentPasswordVisibility event,
    Emitter<EditProfileState> emit,
  ) {
    emit(
      state.copyWith(
        currentPasswordObscureText: !state.currentPasswordObscureText,
      ),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    currentPasswordController.dispose();
    newPassordController.dispose();
    confirmNewPasswordController.dispose();
    return super.close();
  }
}
