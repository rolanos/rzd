part of 'rest_objects_bloc.dart';

sealed class RestObjectsEvent extends Equatable {
  const RestObjectsEvent();

  @override
  List<Object> get props => [];
}

class GetSankurObjects extends RestObjectsEvent {}
