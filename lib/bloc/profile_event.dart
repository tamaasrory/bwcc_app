part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetDaftarKeluargaEvent extends ProfileEvent {}

class AddDataKeluargaEvent extends ProfileEvent {
  final Pasien data;

  const AddDataKeluargaEvent(this.data);

  @override
  List<Object> get props => [data];
}

class UploadFotoKeluargaEvent extends ProfileEvent {
  final String id;
  final String path;

  const UploadFotoKeluargaEvent({required this.id, required this.path});

  @override
  List<Object> get props => [path, id];
}

class UploadFotoPribadiEvent extends ProfileEvent {
  final String path;

  const UploadFotoPribadiEvent(this.path);

  @override
  List<Object> get props => [path];
}

class PostGantiPasswordEvent extends ProfileEvent {}

class PostUbahProfileEvent extends ProfileEvent {
  final Pasien data;

  const PostUbahProfileEvent(this.data);

  @override
  List<Object> get props => [data];
}
