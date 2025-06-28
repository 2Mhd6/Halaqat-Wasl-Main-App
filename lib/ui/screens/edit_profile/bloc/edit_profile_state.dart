part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}
final class EditProfileLoading extends EditProfileState {}
final class EditProfileData extends EditProfileState {}
final class EditProfileError extends EditProfileState {}

