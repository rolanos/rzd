part of 'fuel_type_cubit.dart';

sealed class FuelTypeState extends Equatable {
  const FuelTypeState();

  @override
  List<Object> get props => [];
}

class FuelTypeEmpty extends FuelTypeState {}

class FuelTypeInitial extends FuelTypeState {
  final Map<int, String> fuels;

  const FuelTypeInitial({required this.fuels});
}
