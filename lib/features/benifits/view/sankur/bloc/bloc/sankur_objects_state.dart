part of 'sankur_objects_bloc.dart';

sealed class SankurObjectsState extends Equatable {
  const SankurObjectsState();

  @override
  List<Object> get props => [];
}

final class SankurObjectsEmpty extends SankurObjectsState {}

final class SankurObjectsInitial extends SankurObjectsState {
  final List<Sanprof> objects;

  const SankurObjectsInitial({required this.objects});
}
