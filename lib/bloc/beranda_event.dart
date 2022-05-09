part of 'beranda_bloc.dart';

abstract class BerandaEvent extends Equatable {
  const BerandaEvent();

  @override
  List<Object> get props => [];
}

class SetSlideLayananEvent extends BerandaEvent {}
class SetSlideInfoEvent extends BerandaEvent {}
class SetSlideArtikelEvent extends BerandaEvent {}
