part of 'trigger_bloc.dart';

enum TriggerType { general }

abstract class TriggerState extends Equatable {
  @override
  List<Object> get props => [];
}

class TriggerInit extends TriggerState {}

class TriggerAppState extends TriggerState {
  final TriggerType type;
  final String key;
  final dynamic additional;
  TriggerAppState(this.key, this.type, {this.additional});

  @override
  List<Object> get props => [key, type, additional];
}
