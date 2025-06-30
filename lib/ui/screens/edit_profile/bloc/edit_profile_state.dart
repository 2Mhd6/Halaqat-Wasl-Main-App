part of 'edit_profile_bloc.dart';

@immutable
// Base class for bloc states
sealed class EditProfileState {} 


// Initial state
final class EditProfileInitial extends EditProfileState {}
// Loading state when saving data
final class EditProfileLoading extends EditProfileState {}
// Success state when data saved
final class EditProfileData extends EditProfileState {}
// Error state if something went wrong
final class EditProfileError extends EditProfileState {}

