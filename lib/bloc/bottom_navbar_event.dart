part of 'bottom_navbar_bloc.dart';

class BottomNavbarEvent extends Equatable {
  final int index;
  final dynamic data;

  const BottomNavbarEvent(this.index,{this.data});

  @override
  List<Object> get props => [index];
}
