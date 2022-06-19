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

// untuk proses forgot password
class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent(this.email);
}

class RegisterEvent extends AuthEvent {
  final FormRegister formRegister;

  const RegisterEvent(this.formRegister);
}

class SignOutEvent extends AuthEvent {}
