part of 'append_bloc.dart';

sealed class AppendState extends Equatable {
  const AppendState();

  @override
  List<Object> get props => [];
}

final class AppendEmpty extends AppendState {}

class AppendInitital extends AppendState {
  final List<Append> appends;

  const AppendInitital({required this.appends});
}

class AppendSendLoading extends AppendState {}

class AppendSended extends AppendState {}
