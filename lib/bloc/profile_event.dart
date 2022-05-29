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

class PostChangePasswordEvent extends ProfileEvent {
  final String currentPassword;
  final String newPassword;

  const PostChangePasswordEvent({required this.currentPassword, required this.newPassword});

  @override
  List<Object> get props => [currentPassword, newPassword];
}

class GetProfileEvent extends ProfileEvent {}

class PostUbahProfileKeluargaEvent extends ProfileEvent {
  final Pasien data;

  const PostUbahProfileKeluargaEvent(this.data);

  @override
  List<Object> get props => [data];
}

class PostUpdateProfileEvent extends ProfileEvent {
  final String username;
  final String noHp;

  const PostUpdateProfileEvent({required this.username, required this.noHp});

  @override
  List<Object> get props => [username, noHp];
}
