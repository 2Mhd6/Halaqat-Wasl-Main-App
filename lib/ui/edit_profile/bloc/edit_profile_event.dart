part of 'edit_profile_bloc.dart';

@immutable
// Base class for bloc events
sealed class EditProfileEvent {}

// Event to load profile data
class EditProfileDataLoadRequested extends EditProfileEvent {
}

// Event to reset isSaved state
class ResetIsSavedState extends EditProfileEvent {}

// Event to save profile data
class SaveProfileRequested extends EditProfileEvent{}

// Event to toggle password visibility
class ToggleCurrentPasswordVisibility extends EditProfileEvent {}
class ToggleNewPasswordVisibility extends EditProfileEvent {}
class ToggleConfirmNewPasswordVisibility extends EditProfileEvent {}