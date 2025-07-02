part of 'edit_profile_bloc.dart';

@immutable
// Base class for bloc events
sealed class EditProfileEvent {}

// Event to save profile data
class SaveProfileRequested extends EditProfileEvent{}