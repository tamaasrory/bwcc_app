import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bwcc_app/config/app.dart';
import 'package:bwcc_app/models/pasien.dart';
import 'package:bwcc_app/models/user.dart';
import 'package:bwcc_app/services/pasien.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetDaftarKeluargaEvent>((event, emit) async {
      var response = await PasienService.getDaftarKeluarga();
      logApp('on<GetDaftarKeluargaEvent> ' + jsonEncode(response));
      if (response.condition) {
        emit(ResultDaftarKeluargaState(response.results!));
      }
    });

    on<AddDataKeluargaEvent>((event, emit) async {
      emit(const ProgessState(true, key: 'add_kk'));
      var response = await PasienService.postTambahKeluarga(event.data);
      logApp('on<AddDataKeluargaEvent> ' + jsonEncode(response));

      if (response.condition) {
        logApp('berhasil => ');
        emit(ProgessState(false, extra: response.message, key: 'add_kk'));
      } else {
        emit(const ProgessState(false, key: 'add_kk'));
      }
    });

    on<UploadFotoKeluargaEvent>((event, emit) async {
      emit(const ProgessState(true, key: 'ganti_foto_kk'));
      var response = await PasienService.uploadFotoKeluarga(id: event.id, file: event.path);
      logApp('on<UploadFotoKeluargaEvent> ' + jsonEncode(response));

      if (response.condition) {
        emit(ProgessState(false, extra: response, key: 'ganti_foto_kk'));
      } else {
        emit(ProgessState(false, extra: response, key: 'ganti_foto_kk'));
      }
    });

    on<UploadFotoPribadiEvent>((event, emit) async {
      emit(const ProgessState(true, key: 'ganti_foto_user'));
      var response = await PasienService.uploadFotoPribadi(event.path);
      logApp('on<UploadFotoPribadiEvent> ' + jsonEncode(response));

      if (response.condition) {
        User user = User.fromJson(jsonDecode(await getData<String>(AppConfig.prefUser)));
        user.avatar = response.results!['avatar'];

        await saveData(AppConfig.prefUser, jsonEncode(user.toJson()));

        emit(ProgessState(false, extra: response, key: 'ganti_foto_user'));
      } else {
        emit(ProgessState(false, extra: response, key: 'ganti_foto_user'));
      }
    });

    on<GetProfileEvent>((event, emit) async {
      emit(const ProgessState(true, key: 'get_profile'));
      var response = await PasienService.getProfile();
      logApp('on<GetProfileEvent> ' + jsonEncode(response));

      if (response.condition) {
        emit(ProgessState(false, extra: response, key: 'get_profile'));
        emit(MyProfileState(response.results ?? User()));
      } else {
        emit(ProgessState(false, extra: response, key: 'get_profile'));
      }
    });

    on<PostChangePasswordEvent>((event, emit) async {
      emit(const ProgessState(true, key: 'change_pass'));
      var response = await PasienService.postChangePassword(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );
      logApp('on<PostChangePasswordEvent> ' + jsonEncode(response));

      if (response.condition) {
        logApp('berhasil => ');
        emit(ProgessState(false, extra: response.message, key: 'change_pass'));
      } else {
        emit(ProgessState(false, extra: response.message, key: 'change_pass'));
      }
    });

    on<PostUbahProfileKeluargaEvent>((event, emit) async {
      emit(const ProgessState(true, key: 'detail_keluarga_page'));
      var response = await PasienService.postUbahDataKeluarga(event.data);
      logApp('on<PostUbahProfileEvent> ' + jsonEncode(response));

      if (response.condition) {
        logApp('berhasil => ');
        emit(ProgessState(false, extra: response.message, key: 'detail_keluarga_page'));
      } else {
        emit(const ProgessState(false, key: 'detail_keluarga_page'));
      }
    });

    on<PostUpdateProfileEvent>((event, emit) async {
      emit(const ProgessState(true, key: 'update-profile'));
      var response = await PasienService.postUpdateProfile(
        username: event.username,
        noHandphone: event.noHp,
      );
      logApp('on<PostUbahProfileEvent> ' + jsonEncode(response));

      if (response.condition) {
        logApp('berhasil => ');
        User user = User.fromJson(jsonDecode(await getData<String>(AppConfig.prefUser)));
        user.username = response.results!['username'];
        user.noHandphone = response.results!['no_handphone'];

        await saveData(AppConfig.prefUser, jsonEncode(user.toJson()));

        emit(ProgessState(false, extra: response, key: 'update-profile'));
      } else {
        emit(ProgessState(false, extra: response, key: 'update-profile'));
      }
    });
  }
}
