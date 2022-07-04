part of 'bottom_navbar_bloc.dart';

class BottomNavbarState extends Equatable {
  final int index;
  final dynamic data;

  const BottomNavbarState(this.index,{this.data});

  @override
  List<Object> get props => [index];
}
