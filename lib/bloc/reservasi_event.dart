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

class GetDaftarKeluargaEvent extends ReservasiEvent {}

class GetRiwayatEvent extends ReservasiEvent {}

class GetInfoDokterEvent extends ReservasiEvent {}

class GetDetailRiwayatEvent extends ReservasiEvent {
  final String noReservasi;

  @override
  List<Object> get props => [noReservasi];

  const GetDetailRiwayatEvent(this.noReservasi);
}

class PostReservasiEvent extends ReservasiEvent {
  final FormReservasi formReservasi;
  const PostReservasiEvent(this.formReservasi);
}

class PostKonfirmasiBayarEvent extends ReservasiEvent {
  final String noReservasi;
  final String imagePath;
  const PostKonfirmasiBayarEvent(this.noReservasi, this.imagePath);
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
