part of 'beranda_bloc.dart';

abstract class BerandaState extends Equatable {
  const BerandaState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends BerandaState {}

class SlideLayananState extends BerandaState {
  final List<LayananKami> data;

  const SlideLayananState(this.data);
}

class SlideInfoState extends BerandaState {
  final List<Info> data;

  const SlideInfoState(this.data);
}

class SlideArtikelState extends BerandaState {
  final List<Artikel> data;

  const SlideArtikelState(this.data);
}

class ResultDetailArtikelState extends BerandaState {
  final Artikel data;

  const ResultDetailArtikelState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultDetailInfoState extends BerandaState {
  final Info data;

  const ResultDetailInfoState(this.data);

  @override
  List<Object> get props => [data];
}
