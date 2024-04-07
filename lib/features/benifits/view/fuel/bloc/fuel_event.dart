part of 'fuel_bloc.dart';

sealed class FuelEvent extends Equatable {
  const FuelEvent();

  @override
  List<Object> get props => [];
}

class FuelSend extends FuelEvent {
  final FuelForm fuelForm;

  const FuelSend({required this.fuelForm});
}
