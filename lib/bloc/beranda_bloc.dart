import 'package:bloc/bloc.dart';
import 'package:bwcc_app/models/artikel.dart';
import 'package:bwcc_app/models/info.dart';
import 'package:bwcc_app/services/artikel.dart';
import 'package:bwcc_app/services/info.dart';
import 'package:equatable/equatable.dart';
import '../models/layanan_kami.dart';
import '../services/layanan.dart';

part 'beranda_event.dart';
part 'beranda_state.dart';

class BerandaBloc extends Bloc<BerandaEvent, BerandaState> {
  BerandaBloc() : super(HomeInitial()) {
    on<SetSlideLayananEvent>((event, emit) async {
      var response = await LayananService.layananKami();
      // logApp('on<SetSlideLayananEvent> => ' + jsonEncode(response));
      if (response.condition) {
        emit(SlideLayananState(response.results!));
      }
    });    
    
    on<SetLayananLainEvent>((event, emit) async {
      var response = await LayananService.layananLain();
      // logApp('on<SetLayananLainEvent> => ' + jsonEncode(response));
      if (response.condition) {
        emit(LayananLainState(response.results!));
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

    on<GetDetailArtikelEvent>((event, emit) async {
      var response = await ArtikelService.getDetail(slug: event.slug);
      // logApp('on<SetSlideLayananEvent> => ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultDetailArtikelState(response.results!));
      }
    });

    on<GetDetailInfoEvent>((event, emit) async {
      var response = await InfoService.getDetail(id: event.id);
      // logApp('on<SetSlideLayananEvent> => ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultDetailInfoState(response.results!));
      }
    });
  }
}
