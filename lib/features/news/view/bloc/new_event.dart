part of 'new_bloc.dart';

sealed class NewEvent extends Equatable {
  const NewEvent();

  @override
  List<Object> get props => [];
}

class GetNews extends NewEvent {}
