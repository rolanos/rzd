part of 'rest_objects_bloc.dart';

sealed class RestObjectsState extends Equatable {
  const RestObjectsState();

  @override
  List<Object> get props => [];
}

class RestObjectsEmpty extends RestObjectsState {}

class RestObjectsInitial extends RestObjectsState {
  final List<Sanprof> sanprofList;

  const RestObjectsInitial({required this.sanprofList});
}
