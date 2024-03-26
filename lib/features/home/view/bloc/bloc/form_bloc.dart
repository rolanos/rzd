import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/core/model/form_data_class.dart';
import 'package:rzd/core/model/form_general.dart';
import 'package:rzd/core/repository/form_repository.dart';

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
  }
}
