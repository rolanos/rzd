part of 'app_info_bloc.dart';

sealed class AppInfoState extends Equatable {
  const AppInfoState();

  @override
  List<Object> get props => [];
}

class AppInfoEmpty extends AppInfoState {}

class AppInfoInitial extends AppInfoState {
  final AppInfo appInfo;

  const AppInfoInitial({required this.appInfo});
}
