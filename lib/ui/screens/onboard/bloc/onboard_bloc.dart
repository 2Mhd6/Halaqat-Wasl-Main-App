import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  
  late final PageController pageController ;
  
  
  OnboardBloc() : super(FirstOnboardState()) {
    pageController = PageController();
    on<PageChangedEvent>(_pageChanged);// Listen for Event and State and handle it
    
  }



// Update the onboarding state with the new page.
  void _pageChanged(PageChangedEvent event, Emitter<OnboardState> emit){
      emit(switch(state){
        
        FirstOnboardState() => SecondOnboardState(),
        
        SecondOnboardState() => ThirdOnboardState(),
        
        ThirdOnboardState() => EndOnboardState(),
        
        EndOnboardState() => throw UnimplementedError(),
      });
  }


  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
