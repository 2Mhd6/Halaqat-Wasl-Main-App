import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:halaqat_wasl_main_app/data/user_data.dart';
import 'package:halaqat_wasl_main_app/model/user_model/user_model.dart';
import 'package:halaqat_wasl_main_app/repo/profile/profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  //initial state
  ProfileBloc() : super(ProfileInitial()) {
    // Listen for the ProfileDataLoadRequested event and handle it.
    on<ProfileDataLoadRequested>(_profileDataLoadRequested);

    // Listen for the ProfileSignOutRequested event and handle it.
    on<ProfileSignOutRequested>(_profileSignOutRequested);
  }

  Future<void> _profileDataLoadRequested(
    ProfileDataLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading()); //Emit loading state
    final user = GetIt.I.get<UserData>().user;
    emit(ProfileData(data: user!)); // Emit the loaded profile data
  }

  Future<void> _profileSignOutRequested(
    ProfileSignOutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      // Sign out the user
      emit(ProfileLoading()); // Emit loading state while signing out
      await ProfileRepo.signOut();
      // Sign out the user by clearing the user data.
      GetIt.I.get<UserData>().user = null;
      // Emit an initial state after signing out.
      emit(ProfileInitial());
    } catch (error) {
      emit(
        ProfileError(message: error.toString()),
      ); // Emit error state if sign out fails
    }
  }
}
