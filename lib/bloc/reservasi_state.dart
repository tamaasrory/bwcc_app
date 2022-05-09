part of 'reservasi_bloc.dart';

abstract class ReservasiState extends Equatable {
  const ReservasiState();

  @override
  List<Object> get props => [];
}

class ReservasiInitial extends ReservasiState {}

class ResultCariDokterState extends ReservasiState {
  final List<Dokter> data;

  const ResultCariDokterState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultGetPoliState extends ReservasiState {
  final List<Select> data;

  const ResultGetPoliState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultGetDokterState extends ReservasiState {
  final List<Select> data;

  const ResultGetDokterState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultGetHariState extends ReservasiState {
  final List data;

  const ResultGetHariState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultGetWaktuState extends ReservasiState {
  final List<Select> data;

  const ResultGetWaktuState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultGetMetodePembayaranState extends ReservasiState {
  final List<Select> data;

  const ResultGetMetodePembayaranState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultGetDetailDokterState extends ReservasiState {
  final DetailDokter data;

  const ResultGetDetailDokterState(this.data);

  @override
  List<Object> get props => [data];
}

class ProgessState extends ReservasiState {
  final bool loading;

  const ProgessState(this.loading);

  @override
  List<Object> get props => [loading];
}
