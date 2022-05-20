part of 'trigger_bloc.dart';

abstract class TriggerEvent extends Equatable {
  const TriggerEvent();

  @override
  List<Object> get props => [];
}

class TriggerAppEvent extends TriggerEvent {
  final TriggerType type;
  final String key;
  final dynamic additional;
  const TriggerAppEvent(this.key, this.type, {this.additional = ''});
}
