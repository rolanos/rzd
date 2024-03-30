part of 'form_bloc.dart';

sealed class FormEvent {
  const FormEvent();
}

class GetForms extends FormEvent {}

class GetFormInfo extends FormEvent {
  final String formKey;

  const GetFormInfo({required this.formKey});
}

class SendForm extends FormEvent {
  final FormDataClass data;

  SendForm({required this.data});
}
