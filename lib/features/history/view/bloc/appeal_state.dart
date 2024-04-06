part of 'appeal_bloc.dart';

sealed class AppealState extends Equatable {
  const AppealState();

  @override
  List<Object> get props => [];
}

class AppealInitial extends AppealState {
  final List<Appeal> appeals;

  const AppealInitial({this.appeals = const []});
}

class MessageError extends AppealState {
  final String message;

  const MessageError({required this.message});
}

class AppealLoading extends AppealState {}
