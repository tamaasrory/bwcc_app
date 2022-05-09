part of 'reservasi_bloc.dart';

abstract class ReservasiEvent extends Equatable {
  const ReservasiEvent();

  @override
  List<Object> get props => [];
}

class CariDokterEvent extends ReservasiEvent {
  final String poliId;
  final String? hari;

  @override
  List<Object> get props => [poliId];

  const CariDokterEvent({required this.poliId, this.hari});
}

class GetPoliEvent extends ReservasiEvent {}

class GetMetodePembayaranEvent extends ReservasiEvent {}

class PostReservasiEvent extends ReservasiEvent {
  final FormReservasi formReservasi;
  const PostReservasiEvent(this.formReservasi);
}

class GetDokterReservasiEvent extends ReservasiEvent {
  final String poliId;

  @override
  List<Object> get props => [poliId];

  const GetDokterReservasiEvent({required this.poliId});
}

class GetHariReservasiEvent extends ReservasiEvent {
  final String dokId;
  final String poliId;

  @override
  List<Object> get props => [dokId, poliId];

  const GetHariReservasiEvent({
    required this.dokId,
    required this.poliId,
  });
}

class GetWaktuReservasiEvent extends ReservasiEvent {
  final String dokId;
  final String poliId;
  final String hari;

  @override
  List<Object> get props => [dokId, poliId, hari];

  const GetWaktuReservasiEvent({
    required this.dokId,
    required this.poliId,
    required this.hari,
  });
}

class GetDetailDokterEvent extends ReservasiEvent {
  final String id;

  const GetDetailDokterEvent(this.id);

  @override
  List<Object> get props => [id];
}
