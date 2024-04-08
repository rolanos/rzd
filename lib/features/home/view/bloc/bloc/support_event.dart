part of 'support_bloc.dart';

sealed class SupportEvent extends Equatable {
  const SupportEvent();

  @override
  List<Object> get props => [];
}

class SupportSend extends SupportEvent {
  final String topic;
  final String body;
  final File? doc;

  const SupportSend({required this.topic, required this.body, this.doc});
}
