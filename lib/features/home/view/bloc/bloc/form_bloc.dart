import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:rzd/core/model/form_data_class.dart';
import 'package:rzd/core/model/form_general.dart';
import 'package:rzd/core/repository/form_repository.dart';
import 'package:rzd/features/home/data/repository/support_repository.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormBlocState> {
  FormRepository formRepository = FormRepository();
  FormBloc() : super(const FormInitial(forms: [])) {
    on<GetForms>((event, emit) async {
      try {
        final forms = await formRepository.getForms();
        emit(FormInitial(forms: forms));
      } catch (e) {
        log(e.toString());
      }
    });
    on<GetFormInfo>((event, emit) async {
      try {
        final form = await formRepository.getFormDescription(event.formKey);
        final forms = await formRepository.getForms();

        emit(FormInitial(forms: forms, form: form));
      } catch (e) {
        log(e.toString());
      }
    });
    on<SendForm>((event, emit) async {
      try {
        final copyState = state;
        final validate = await formRepository.validateForm(
            event.data.formKey ?? '',
            FormDescription.toMapFromList(event.data.formDescription));
        if (validate) {
          final result = await formRepository.sendForm(
            event.data.formKey ?? '',
            FormDescription.toMapFromList(event.data.formDescription),
          );
          if (result) {
            emit(FormSended());
            emit(copyState);
          }
        }
      } catch (e) {
        log(e.toString());
      }
    });
    on<SendBfMaterialForm>((event, emit) async {
      try {
        final copyState = state;
        emit(FormSendLoading());
        await SupportRepository().sendForm(
          event.form.topic,
          event.form.request ?? '',
          event.form.file,
        );

        emit(FormSended());
        emit(copyState);
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
