part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}
//initial state
final class ProfileInitial extends ProfileState {}

// The state when data is being loaded
final class ProfileLoading extends ProfileState {}

// The state when the profile data has been successfully loaded.
final class ProfileData extends ProfileState {
  final List<ProfileItem> data;
  ProfileData({required this.data});
}

// The state when an error occurs during data loading, with a message.
final class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});  
}
