part of 'sankur_objects_bloc.dart';

sealed class SankurObjectsEvent extends Equatable {
  const SankurObjectsEvent();

  @override
  List<Object> get props => [];
}

class GetList extends SankurObjectsEvent {}
