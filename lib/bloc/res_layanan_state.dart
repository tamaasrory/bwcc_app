part of 'res_layanan_bloc.dart';

abstract class ResLayananState extends Equatable {
  const ResLayananState();

  @override
  List<Object> get props => [];
}

class ReservasiInitial extends ResLayananState {}

class ResultGetLayananState extends ResLayananState {
  final List<Select> data;

  const ResultGetLayananState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultGetHariState extends ResLayananState {
  final List data;

  const ResultGetHariState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultGetWaktuState extends ResLayananState {
  final List<Select> data;

  const ResultGetWaktuState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultGetMetodePembayaranState extends ResLayananState {
  final List<Select> data;

  const ResultGetMetodePembayaranState(this.data);

  @override
  List<Object> get props => [data];
}

class ProgessState extends ResLayananState {
  final bool loading;
  final dynamic extra;

  const ProgessState(this.loading, {this.extra});

  @override
  List<Object> get props => [loading];
}

