part of 'appeal_bloc.dart';

sealed class AppealEvent extends Equatable {
  const AppealEvent();

  @override
  List<Object> get props => [];
}

class GetAppealsEvent extends AppealEvent {}
