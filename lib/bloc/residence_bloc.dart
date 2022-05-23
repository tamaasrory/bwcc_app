import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/select.dart';
import 'package:bwcc_app/services/residence.dart';
import 'package:equatable/equatable.dart';

part 'residence_event.dart';
part 'residence_state.dart';

class ResidenceBloc extends Bloc<ResidenceEvent, ResidenceState> {
  ResidenceBloc() : super(ResidenceInitial()) {
    on<GetProvincesEvent>((event, emit) async {
      var response = await ResidenceService.getProvinsi();
      logApp('on<GetProvincesEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultProvincesState(response.results!));
      }
    });

    on<GetCitiesEvent>((event, emit) async {
      var response = await ResidenceService.getKabupaten(event.id);
      logApp('on<GetCitiesEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultCitiesState(response.results!));
      }
    });

    on<GetDistrictsEvent>((event, emit) async {
      var response = await ResidenceService.getDistricts(event.id);
      logApp('on<GetDistrictsEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultDistrictsState(response.results!));
      }
    });

    on<GetVillagesEvent>((event, emit) async {
      var response = await ResidenceService.getvVillages(event.id);
      logApp('on<GetVillagesEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultVillagesState(response.results!));
      }
    });
  }
}
