part of 'sankur_form_bloc.dart';

sealed class SankurFormState extends Equatable {
  const SankurFormState();

  @override
  List<Object> get props => [];
}

final class SankurFormInitial extends SankurFormState {}

class SankurSendLoading extends SankurFormState {}

class SankurSended extends SankurFormState {}
