part of 'fuel_bloc.dart';

sealed class FuelState extends Equatable {
  const FuelState();

  @override
  List<Object> get props => [];
}

class FuelEmpty extends FuelState {}

class FuelSendLoading extends FuelState {}

class FuelSended extends FuelState {}
