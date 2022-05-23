part of 'residence_bloc.dart';

abstract class ResidenceState extends Equatable {
  const ResidenceState();
  
  @override
  List<Object> get props => [];
}

class ResidenceInitial extends ResidenceState {}


class ResultProvincesState extends ResidenceState {
  final List<Select> data;

  const ResultProvincesState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultCitiesState extends ResidenceState {
  final List<Select> data;

  const ResultCitiesState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultDistrictsState extends ResidenceState {
  final List<Select> data;

  const ResultDistrictsState(this.data);

  @override
  List<Object> get props => [data];
}

class ResultVillagesState extends ResidenceState {
  final List<Select> data;

  const ResultVillagesState(this.data);

  @override
  List<Object> get props => [data];
}
