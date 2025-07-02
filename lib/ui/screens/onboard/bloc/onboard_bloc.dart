import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  // Page controller for managing PageView navigation
  late final PageController pageController;

  // The initial state is FirstOnboardState (first onboarding screen)
  OnboardBloc() : super(FirstOnboardState()) {

  // Initialize PageController
    pageController = PageController();
  // Listen for PageChangedEvent and call _pageChanged
    on<PageChangedEvent>(_pageChanged);
  }
// Handles page change: switch to the next onboarding state
  void _pageChanged(PageChangedEvent event, Emitter<OnboardState> emit) {
    emit(switch (state) {
      FirstOnboardState() => SecondOnboardState(),

      SecondOnboardState() => ThirdOnboardState(),

      ThirdOnboardState() => EndOnboardState(),

      EndOnboardState() => throw UnimplementedError(),
    });
  }

  @override
  Future<void> close() {
    // Dispose PageController when bloc is closed to free memory
    pageController.dispose();
    return super.close();
  }
}
