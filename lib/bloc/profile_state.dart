part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class MyProfileState extends ProfileState {
  final User data;

  const MyProfileState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultDaftarKeluargaState extends ProfileState {
  final List<Pasien> data;

  const ResultDaftarKeluargaState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultUbahDataKeluargaState extends ProfileState {
  final Pasien data;

  const ResultUbahDataKeluargaState(this.data);

  @override
  List<Object> get props => [data];
}

class ProgessState extends ProfileState {
  final bool loading;
  final dynamic extra;
  final String? key;

  const ProgessState(this.loading, {this.key, this.extra});

  @override
  List<Object> get props => [loading];
}
