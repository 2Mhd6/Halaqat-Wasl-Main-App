import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPassordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  EditProfileBloc() : super(EditProfileInitial()) {
    on<SaveProfileRequested>(_saveProfileRequested);
  }



  Future<void> _saveProfileRequested(SaveProfileRequested event, Emitter<EditProfileState> emit)async {
    emit(EditProfileLoading());
    final name = nameController.text;
    final email = emailController.text;
    final phone = phoneController.text;
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
