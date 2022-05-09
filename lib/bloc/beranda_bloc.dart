import 'package:bloc/bloc.dart';
import 'package:bwcc_app/models/artikel.dart';
import 'package:bwcc_app/models/info.dart';
import 'package:bwcc_app/services/artikel.dart';
import 'package:bwcc_app/services/info.dart';
import 'package:equatable/equatable.dart';
import '../models/layanan_kami.dart';
import '../services/layanan_kami.dart';

part 'beranda_event.dart';
part 'beranda_state.dart';

class BerandaBloc extends Bloc<BerandaEvent, BerandaState> {
  BerandaBloc() : super(HomeInitial()) {
    on<SetSlideLayananEvent>((event, emit) async {
      var response = await LayananKamiService.index();
      // logApp('on<SetSlideLayananEvent> => ' + jsonEncode(response));
      if (response.condition) {
        emit(SlideLayananState(response.results!));
      }
    });

    on<SetSlideInfoEvent>((event, emit) async {
      var response = await InfoService.index();
      // logApp('on<SetSlideLayananEvent> => ' + jsonEncode(response));
      if (response.condition) {
        emit(SlideInfoState(response.results!));
      }
    });

    on<SetSlideArtikelEvent>((event, emit) async {
      var response = await ArtikelService.index();
      // logApp('on<SetSlideLayananEvent> => ' + jsonEncode(response));
      if (response.condition) {
        emit(SlideArtikelState(response.results!));
      }
    });
  }
}
