part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}


class SaveProfileRequested extends EditProfileEvent{}