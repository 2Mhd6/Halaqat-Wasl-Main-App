part of 'onboard_bloc.dart';

sealed class OnboardEvent {}

class PageChangedEvent extends OnboardEvent {
  PageChangedEvent(); //Navigates to the next page.
}
