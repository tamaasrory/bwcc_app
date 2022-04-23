// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app.dart';
import '../models/user.dart';
import '../services/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthAttampState(data: User())) {
    on<LoginEvent>((event, emit) async {
      emit(const AuthProgessState(true));

      var httpResponse = await AuthService.login(
        email: event.email,
        password: event.password,
      );

      emit(const AuthProgessState(false));

      try {
        logApp(httpResponse.toJson().toString());

        if (httpResponse.condition) {
          String user = jsonEncode(httpResponse.results!.toJson());
          SharedPreferences preferences = await SharedPreferences.getInstance();

          preferences.setBool(AppConfig.prefIsLogged, true);
          preferences.setString(AppConfig.prefUser, user);

          if (Platform.isAndroid) {
            preferences.commit();
          }

          emit(AuthAttampState(
            data: httpResponse.results!,
            isLogged: true,
            message: 'Login Berhasil, Sedang mengalihkan ke halaman utama',
          ));
        } else {
          emit(AuthAttampState(
            data: User(),
            isLogged: false,
            message: httpResponse.message!,
          ));
        }
      } catch (e) {
        // logApp('Error on on<LoginEvent> => ' + e.toString());

        emit(AuthAttampState(
          data: User(),
          isLogged: false,
          message: 'Login gagal, mohon periksa koneksi internet anda',
        ));
      }
    });

    on<SignOutEvent>((event, emit) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool isLogged = preferences.getBool(AppConfig.prefIsLogged) ?? false;
      User user = User();

      if (isLogged) {
        String dataUser = preferences.getString(AppConfig.prefUser)!;
        user = User.fromJson(jsonDecode(dataUser));
      }

      var httpResponse = await AuthService.logout(
        email: user.username,
      );

      logApp('httpResponse logout => ' + jsonEncode(httpResponse.toJson()));

      if (httpResponse.condition) {
        preferences.setBool(AppConfig.prefIsLogged, false);
        preferences.setString(AppConfig.prefUser, "");

        if (Platform.isAndroid) {
          preferences.commit();
        }
        emit(AuthAttampState(data: User(), isLogged: false));
      }
    });

    on<CheckAndSetupLoginEvent>((event, emit) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool isLogged = preferences.getBool(AppConfig.prefIsLogged) ?? false;
      User user = User();

      if (isLogged) {
        String dataUser = preferences.getString(AppConfig.prefUser)!;
        logApp('on<CheckAndSetupLoginData> => logged => ' + dataUser);
        user = User.fromJson(jsonDecode(dataUser));
        logApp('on<CheckAndSetupLoginData> => ' + jsonEncode(user.toJson()));
      }

      emit(AuthAttampState(data: user, isLogged: isLogged));
    });
  }
}
