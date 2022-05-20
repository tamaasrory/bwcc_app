import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/pasien.dart';
import 'package:bwcc_app/services/reservasi.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetDaftarKeluargaEvent>((event, emit) async {
      var response = await ReservasiService.getDaftarKeluarga();
      logApp('on<GetDaftarKeluargaEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultDaftarKeluargaState(response.results!));
      }
    });

    on<AddDataKeluargaEvent>((event, emit) {});

    on<EditDataKeluargaEvent>((event, emit) {});

    on<PostGantiPasswordEvent>((event, emit) {});

    on<PostUbahProfileEvent>((event, emit) {});
  }
}
