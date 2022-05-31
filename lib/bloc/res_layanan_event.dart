part of 'res_layanan_bloc.dart';

abstract class ResLayananEvent extends Equatable {
  const ResLayananEvent();

  @override
  List<Object> get props => [];
}

class CariDokterEvent extends ResLayananEvent {
  final String poliId;
  final String? hari;

  @override
  List<Object> get props => [poliId];

  const CariDokterEvent({required this.poliId, this.hari});
}

class GetPoliEvent extends ResLayananEvent {}

class GetMetodePembayaranEvent extends ResLayananEvent {}

class GetDaftarKeluargaEvent extends ResLayananEvent {}

class GetRiwayatEvent extends ResLayananEvent {}

class GetInfoDokterEvent extends ResLayananEvent {}

class GetDetailRiwayatEvent extends ResLayananEvent {
  final String noReservasi;

  @override
  List<Object> get props => [noReservasi];

  const GetDetailRiwayatEvent(this.noReservasi);
}

class PostReservasiEvent extends ResLayananEvent {
  final ReservasiLayanan formReservasi;
  const PostReservasiEvent(this.formReservasi);
}

class PostKonfirmasiBayarEvent extends ResLayananEvent {
  final String noReservasi;
  final String imagePath;
  const PostKonfirmasiBayarEvent(this.noReservasi, this.imagePath);
}

class GetLayananEvent extends ResLayananEvent {}

class GetHariReservasiEvent extends ResLayananEvent {
  final String layanan;

  @override
  List<Object> get props => [layanan];

  const GetHariReservasiEvent({required this.layanan});
}

class GetWaktuReservasiEvent extends ResLayananEvent {
  final String layanan;
  final String hari;

  @override
  List<Object> get props => [layanan, hari];

  const GetWaktuReservasiEvent({
    required this.layanan,
    required this.hari,
  });
}

class GetDetailDokterEvent extends ResLayananEvent {
  final String id;

  const GetDetailDokterEvent(this.id);

  @override
  List<Object> get props => [id];
}
