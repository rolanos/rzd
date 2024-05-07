part of 'append_bloc.dart';

sealed class AppendEvent extends Equatable {
  const AppendEvent();

  @override
  List<Object> get props => [];
}

class AppendGet extends AppendEvent {
  final String type;

  const AppendGet({required this.type});
}

class AppendSend extends AppendEvent {
  final String id;
  final String comment;
  final File? file;

  const AppendSend(
      {required this.id, required this.comment, required this.file});
}
