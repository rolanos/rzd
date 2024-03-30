part of 'new_bloc.dart';

sealed class NewState extends Equatable {
  const NewState();

  @override
  List<Object> get props => [];
}

class NewEmpty extends NewState {}

final class NewInitial extends NewState {
  final List<NewInfo> news;

  const NewInitial({required this.news});
}
