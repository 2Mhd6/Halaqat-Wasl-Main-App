import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:halaqat_wasl_main_app/data/user_data.dart';
import 'package:halaqat_wasl_main_app/model/user_model/user_model.dart';
import 'package:halaqat_wasl_main_app/repo/auth/auth_repo.dart';
import 'package:halaqat_wasl_main_app/repo/user_operation/user_operation_repo.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  // -- Related to the form
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  String selectedGender = 'male';

  // -- Handling UI State 
  bool isShowPassword = false;


  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    
    // -- Handling UI
    on<TogglePasswordViabilityEvent>((event, emit){
      isShowPassword = !isShowPassword;
      emit(SuccessTogglingPasswordViability());
    });
    
    
    on<SelectedGenderEvent>((event, emit) {
      selectedGender = event.genderIndex == 1 ? 'male' : 'female';
      emit(SuccessSelectingGender());
    });

    on<SignUpEvent>(signUp);

    on<LogInEvent>(login);
  }

  FutureOr<void> signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    final email = emailController.text;
    final password = passwordController.text;

    try{

      emit(LoadingState());
      
      if (email.trim().isEmpty || password.trim().isEmpty) {
        throw 'Email and password must not be empty';
      }

      
      final res = await AuthRepo.signUp(email: email, password: password);

      final UserModel user = UserModel(
        userId: res.user!.id,
        notificationId: Uuid().v4(), 
        fullName: fullNameController.text, 
        email: email.toLowerCase(), 
        role: 'user',
        phoneNumber: '+966${phoneNumberController.text}', 
        gender: selectedGender
      );

      // -- Inserting a record in users table
      await UserOperationRepo.insertUserDetailsIntoDB(user: user);

      // -- inject the user data 
      GetIt.I.get<UserData>().user = await UserOperationRepo.getUserDetailsFromDB();

      emit(SuccessState(successMessage: 'Welcome ${fullNameController.text}'));
      
      clearControllers();
    }catch(e){
      clearControllers();
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> login(LogInEvent event, Emitter<AuthState> emit) async{
    
    final email = emailController.text;
    final password = passwordController.text;

    try {
      emit(LoadingState());

      if (email.trim().isEmpty || password.trim().isEmpty) {
        throw 'Email and password must not be empty';
      }

      final res = await AuthRepo.logIn(email: email, password: password);

      // -- inject the user data 
      GetIt.I.get<UserData>().user = await UserOperationRepo.getUserDetailsFromDB();


      clearControllers();
      emit(SuccessState(successMessage: 'Welcome Back ${res.user!.email}'));
      
    } catch (e) {
      clearControllers();
      emit(ErrorState(errorMessage: e.toString()));
    }
  }


  void clearControllers() {
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneNumberController.clear();
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    return super.close();
  }
}


