part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class GoingToNextPage extends OnboardingState{}

final class SuccessPresentingOnboarding extends OnboardingState {}
