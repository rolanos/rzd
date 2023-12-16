part of 'history_bloc.dart';

class HistoryState extends Equatable {
  final List<UserHistory> history;

  HistoryState({this.history = const []});

  @override
  List<Object?> get props => [history];
}
