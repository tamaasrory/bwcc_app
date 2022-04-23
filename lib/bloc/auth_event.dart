part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// berguna untuk memut data login dari preference,
// ketika buka app lagi setelah di tutup, dengan kondisi
// data login sudah tersimpan di preference
class CheckAndSetupLoginEvent extends AuthEvent {}

// untuk proses login
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);
}

class SignOutEvent extends AuthEvent {}
