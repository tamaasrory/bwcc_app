part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ResultDaftarKeluargaState extends ProfileState {
  final List<Pasien> data;

  const ResultDaftarKeluargaState(this.data);

  @override
  List<Object> get props => [data];
}
