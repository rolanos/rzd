part of 'app_info_bloc.dart';

sealed class AppInfoEvent extends Equatable {
  const AppInfoEvent();

  @override
  List<Object> get props => [];
}

class GetInfo extends AppInfoEvent {}
