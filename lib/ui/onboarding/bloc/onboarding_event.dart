part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {}

final class GoToNextPageEvent extends OnboardingEvent{

  final int index;

  GoToNextPageEvent({required this.index});
}

final class OnSwipePageEvent extends OnboardingEvent{}

final class SkipOnboardingEvent extends OnboardingEvent{}