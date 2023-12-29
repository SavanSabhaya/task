part of 'home_bloc.dart';

@immutable
abstract class HomeEvent  {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}
class HomeInitEvent extends HomeEvent{}