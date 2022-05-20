part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetDaftarKeluargaEvent extends ProfileEvent {}

class AddDataKeluargaEvent extends ProfileEvent {}

class EditDataKeluargaEvent extends ProfileEvent {}

class PostGantiPasswordEvent extends ProfileEvent {}

class PostUbahProfileEvent extends ProfileEvent {}
