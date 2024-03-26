part of 'form_bloc.dart';

sealed class FormBlocState {
  const FormBlocState();
}

final class FormInitial extends FormBlocState {
  final List<FormGeneral> forms;
  final FormDataClass? form;

  const FormInitial({required this.forms, this.form});
}

class FormError extends FormBlocState {}
