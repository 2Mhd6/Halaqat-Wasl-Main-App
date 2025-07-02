part of 'bottom_nav_bloc.dart';

@immutable
sealed class BottomNavEvent {}


final class ChangeIndexEvent extends BottomNavEvent{
  final index; 
  ChangeIndexEvent({required this.index});
}