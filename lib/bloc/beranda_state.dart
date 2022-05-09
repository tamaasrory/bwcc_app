part of 'beranda_bloc.dart';

abstract class BerandaState extends Equatable {
  const BerandaState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends BerandaState {}

class SlideLayananState extends BerandaState {
  final List<LayananKami> slides;

  const SlideLayananState(this.slides);
}

class SlideInfoState extends BerandaState {
  final List<Info> slides;

  const SlideInfoState(this.slides);
}

class SlideArtikelState extends BerandaState {
  final List<Artikel> slides;

  const SlideArtikelState(this.slides);
}
