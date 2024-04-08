part of 'teeth_bloc.dart';

sealed class TeethState extends Equatable {
  const TeethState();

  @override
  List<Object> get props => [];
}

final class TeethEmpty extends TeethState {}

final class TeethInitial extends TeethState {
  final Map<String, dynamic> services;

  const TeethInitial({required this.services});
}

class TeethSendLoading extends TeethState {}

class TeethSended extends TeethState {}
