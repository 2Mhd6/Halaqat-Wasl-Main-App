import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  // Text controllers to manage form fields' values
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPassordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  //initial state
  EditProfileBloc() : super(EditProfileInitial()) {
    on<SaveProfileRequested>(_saveProfileRequested);
  }

  // Handler for the save profile event
  Future<void> _saveProfileRequested(
    SaveProfileRequested event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileLoading());

    // Read current values from the text controllers
    // final name = nameController.text;
    // final email = emailController.text;
    // final phone = phoneController.text;
    // Emit state updated to data saved (success)
    emit(EditProfileData());
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
