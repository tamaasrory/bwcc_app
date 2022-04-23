import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../config/app.dart';
import '../models/layanan_kami.dart';
import '../services/layanan_kami.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<SetSlideLayananEvent>((event, emit) async {
      var response = await LayananKamiService.index();
      logApp('on<SetSlideLayananEvent> => ' + jsonEncode(response));
      if (response.condition) {
        emit(SlideLayananState(response.results!));
      }
    });
  }
}
