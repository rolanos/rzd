part of 'teeth_bloc.dart';

sealed class TeethEvent extends Equatable {
  const TeethEvent();

  @override
  List<Object> get props => [];
}

class TeethSend extends TeethEvent {
  final TeethForm teethForm;

  const TeethSend({required this.teethForm});
}

class TeethGet extends TeethEvent {
  const TeethGet();
}
