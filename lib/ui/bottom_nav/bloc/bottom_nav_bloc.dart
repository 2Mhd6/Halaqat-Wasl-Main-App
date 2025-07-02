import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {

  int selectedIndex = 0;

  BottomNavBloc() : super(BottomNavInitial()) {
    on<BottomNavEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChangeIndexEvent>(changeIndex);
  }

  FutureOr<void> changeIndex(ChangeIndexEvent event, Emitter<BottomNavState> emit) {
    selectedIndex = event.index;
    emit(SuccessState());
  }
}
