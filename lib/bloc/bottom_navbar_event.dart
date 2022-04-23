part of 'bottom_navbar_bloc.dart';

class BottomNavbarEvent extends Equatable {
  final int index;

  const BottomNavbarEvent(this.index);

  @override
  List<Object> get props => [index];
}
