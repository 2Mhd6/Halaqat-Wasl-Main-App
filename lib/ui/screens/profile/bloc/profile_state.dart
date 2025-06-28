part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoading extends ProfileState {}
final class ProfileData extends ProfileState {
  final List<ProfileItem> data;
  ProfileData({required this.data});

}
final class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}
