part of 'residence_bloc.dart';

abstract class ResidenceEvent extends Equatable {
  const ResidenceEvent();

  @override
  List<Object> get props => [];
}

class GetProvincesEvent extends ResidenceEvent {}

class GetCitiesEvent extends ResidenceEvent {
  final String id;

  const GetCitiesEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetDistrictsEvent extends ResidenceEvent {
  final String id;

  const GetDistrictsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetVillagesEvent extends ResidenceEvent {
  final String id;

  const GetVillagesEvent(this.id);

  @override
  List<Object> get props => [id];
}
