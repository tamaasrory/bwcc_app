part of 'bottom_navbar_bloc.dart';

class BottomNavbarState extends Equatable {
  final int index;

  const BottomNavbarState(this.index);

  @override
  List<Object> get props => [index];
}
