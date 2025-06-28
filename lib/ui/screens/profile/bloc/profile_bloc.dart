import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/screens/profile/widgets/profile_item.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileDataLoadRequested>(_profileDataLoadRequested);
  }


  Future<void> _profileDataLoadRequested(ProfileDataLoadRequested event, Emitter<ProfileState> emit)async{
    emit(ProfileLoading());


    emit(ProfileData(data:  [
      ProfileItem(hintText: 'Mohammed Ali Alharbi', icon: 'assets/icons/account.png'),
      ProfileItem(hintText: 'Mohammed@gmail.com', icon: 'assets/icons/email.png'),
      ProfileItem(hintText: '+966 561577821', icon: 'assets/icons/call.png'),
      ProfileItem(hintText: 'Arabic', icon: 'assets/icons/language.png'),
      ProfileItem(hintText: 'Support@Halaqat_wasl.com', icon: 'assets/icons/support.png'),

    ]));
  }
}
