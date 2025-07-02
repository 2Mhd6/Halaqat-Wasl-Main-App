import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/screens/profile/widgets/profile_item.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart'; 
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  //initial state
  ProfileBloc() : super(ProfileInitial()) {
    // Listen for the ProfileDataLoadRequested event and handle it.
    on<ProfileDataLoadRequested>(_profileDataLoadRequested);
  }

  Future<void> _profileDataLoadRequested(
    ProfileDataLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading()); //Emit loading state

    emit(ProfileData(data: [])); // Emit the loaded profile data
  }
}
