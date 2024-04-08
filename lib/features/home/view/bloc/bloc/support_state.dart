part of 'support_bloc.dart';

sealed class SupportState extends Equatable {
  const SupportState();

  @override
  List<Object> get props => [];
}

class SupportEmpty extends SupportState {}

class SupportSendLoading extends SupportState {}

class SupportSended extends SupportState {}
