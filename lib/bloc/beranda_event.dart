part of 'beranda_bloc.dart';

abstract class BerandaEvent extends Equatable {
  const BerandaEvent();

  @override
  List<Object> get props => [];
}

class SetSlideLayananEvent extends BerandaEvent {}

class SetSlideInfoEvent extends BerandaEvent {}

class SetSlideArtikelEvent extends BerandaEvent {}

class GetDetailArtikelEvent extends BerandaEvent {
  final String slug;

  const GetDetailArtikelEvent(this.slug);

  @override
  List<Object> get props => [slug];
}

class GetDetailInfoEvent extends BerandaEvent {
  final String id;

  const GetDetailInfoEvent(this.id);

  @override
  List<Object> get props => [id];
}
