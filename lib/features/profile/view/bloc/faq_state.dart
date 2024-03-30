part of 'faq_bloc.dart';

sealed class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

class FaqEmpty extends FaqState {}

final class FaqInitial extends FaqState {
  final List<FaqInfo> faqs;

  const FaqInitial({required this.faqs});
}
