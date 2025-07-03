import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {

  int currentIdex = 0;

  final PageController pageController = PageController();

  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GoToNextPageEvent>(goToNextPage);

    on<SkipOnboardingEvent>((event, emit) => emit(SuccessPresentingOnboarding()));
  }

  FutureOr<void> goToNextPage(GoToNextPageEvent event, Emitter<OnboardingState> emit) {

    final pageIndex = event.index;

    switch (pageIndex) {
      case 0:
        currentIdex = 1;
        pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
        emit(GoingToNextPage());
      
      case 1: 
        currentIdex = 2;
        pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
        emit(GoingToNextPage());

      case 2: 
        emit(SuccessPresentingOnboarding());
        
    }
  }


  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
