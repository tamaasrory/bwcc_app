part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthAttampState extends AuthState {
  final User data;
  final bool isLogged;
  final String username;
  final String password;
  final String message;

  const AuthAttampState({
    required this.data,
    this.isLogged = false,
    this.message = '',
    this.username = '',
    this.password = '',
  });

  @override
  List<Object> get props => [data, isLogged, message, username, password];
}

class AuthProgessState extends AuthState {
  final bool loading;

  const AuthProgessState(this.loading);
  @override
  List<Object> get props => [loading];
}
