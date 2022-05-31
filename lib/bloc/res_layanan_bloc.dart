import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/reservasi_layanan.dart';
import 'package:bwcc_app/models/select.dart';
import 'package:bwcc_app/services/reservasi_layanan.dart';
import 'package:equatable/equatable.dart';

part 'res_layanan_event.dart';
part 'res_layanan_state.dart';

class ResLayananBloc extends Bloc<ResLayananEvent, ResLayananState> {
  ResLayananBloc() : super(ReservasiInitial()) {
    on<GetMetodePembayaranEvent>((event, emit) async {
      var response = await ReservasiLayananService.getPembayaran();
      logApp('on<GetPembayaranEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultGetMetodePembayaranState(response.results!));
      }
    });

    on<GetLayananEvent>((event, emit) async {
      var response = await ReservasiLayananService.getLayanan();
      // logApp('on<GetLayananEvent> ' + event.poliId + ' --- ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultGetLayananState(response.results!));
      }
    });

    on<GetHariReservasiEvent>((event, emit) async {
      var response = await ReservasiLayananService.getHariReservasi(
        layananId: event.layanan,
      );
      logApp('on<GetHariReservasiEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultGetHariState(response.results!));
      }
    });

    on<GetWaktuReservasiEvent>((event, emit) async {
      var response = await ReservasiLayananService.getWaktuReservasi(
        layananId: event.layanan,
        hari: event.hari,
      );
      logApp('on<GetWaktuReservasiEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultGetWaktuState(response.results!));
      }
    });

    on<PostReservasiEvent>((event, emit) async {
      emit(const ProgessState(true));
      var response = await ReservasiLayananService.postReservasi(event.formReservasi);
      logApp('on<PostReservasiEvent> ' + jsonEncode(response));

      if (response.condition) {
        logApp('berhasil => ');
        emit(ProgessState(false, extra: response.results!['no_reservasi']));
      } else {
        emit(const ProgessState(false));
      }
    });
  }
}
