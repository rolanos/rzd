part of 'sankur_form_bloc.dart';

sealed class SankurFormEvent extends Equatable {
  const SankurFormEvent();

  @override
  List<Object> get props => [];
}

class SankurSend extends SankurFormEvent {
  final SankurForm sankurForm;

  const SankurSend({required this.sankurForm});
}
