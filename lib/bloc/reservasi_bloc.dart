import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/detail_dokter.dart';
import 'package:bwcc_app/models/dokter.dart';
import 'package:bwcc_app/models/form_reservasi.dart';
import 'package:bwcc_app/models/pasien.dart';
import 'package:bwcc_app/models/riwayat_reservasi.dart';
import 'package:bwcc_app/models/select.dart';
import 'package:bwcc_app/services/reservasi.dart';
import 'package:equatable/equatable.dart';

part 'reservasi_event.dart';
part 'reservasi_state.dart';

class ReservasiBloc extends Bloc<ReservasiEvent, ReservasiState> {
  ReservasiBloc() : super(ReservasiInitial()) {
    on<CariDokterEvent>((event, emit) async {
      emit(const ProgessState(true));
      logApp('on<CariDokterEvent> ' + jsonEncode({'poliId': event.poliId, 'hari': event.hari}));
      var response = await ReservasiService.index(poliId: event.poliId, hari: event.hari);
      emit(const ProgessState(false));
      if (response.condition) {
        emit(ResultCariDokterState(response.results!));
      }
    });

    on<GetRiwayatEvent>((event, emit) async {
      var response = await ReservasiService.getRiwayat();
      logApp('on<GetRiwayatEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultRiwayatReservasiState(response.results!));
      }
    });

    on<GetDetailRiwayatEvent>((event, emit) async {
      var response = await ReservasiService.getDetailRiwayat(noReservasi: event.noReservasi);
      logApp('on<GetDetailRiwayatEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultDetailRiwayatState(response.results!));
      }
    });

    on<GetPoliEvent>((event, emit) async {
      var response = await ReservasiService.getAllPoli();
      logApp('on<GetPoliEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultGetPoliState(response.results!));
      }
    });

    on<GetMetodePembayaranEvent>((event, emit) async {
      var response = await ReservasiService.getPembayaran();
      logApp('on<GetPembayaranEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultGetMetodePembayaranState(response.results!));
      }
    });

    on<GetDaftarKeluargaEvent>((event, emit) async {
      var response = await ReservasiService.getDaftarKeluarga();
      logApp('on<GetDaftarKeluargaEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultGetDaftarKeluargaState(response.results!));
      }
    });

    on<GetDokterReservasiEvent>((event, emit) async {
      var response = await ReservasiService.getDokterReservasi(
        poliId: event.poliId,
      );
      // logApp('on<GetDokterReservasiEvent> ' + event.poliId + ' --- ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultGetDokterState(response.results!));
      }
    });

    on<GetHariReservasiEvent>((event, emit) async {
      var response = await ReservasiService.getHariReservasi(
        dokterId: event.dokId,
        poliId: event.poliId,
      );
      logApp('on<GetHariReservasiEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultGetHariState(response.results!));
      }
    });

    on<GetWaktuReservasiEvent>((event, emit) async {
      var response = await ReservasiService.getWaktuReservasi(
        dokterId: event.dokId,
        poliId: event.poliId,
        hari: event.hari,
      );
      logApp('on<GetWaktuReservasiEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultGetWaktuState(response.results!));
      }
    });

    on<PostReservasiEvent>((event, emit) async {
      emit(const ProgessState(true));
      var response = await ReservasiService.postReservasi(event.formReservasi);
      logApp('on<PostReservasiEvent> ' + jsonEncode(response));
      emit(const ProgessState(false));
      if (response.condition) {
        logApp('berhasil => ');
        // emit(ResultGetWaktuState(response.results!));
      }
    });

    on<GetDetailDokterEvent>((event, emit) async {
      var response = await ReservasiService.getDetailDokter(id: event.id);
      logApp('on<GetDetailDokterEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultGetDetailDokterState(response.results!));
      }
    });
  }
}
