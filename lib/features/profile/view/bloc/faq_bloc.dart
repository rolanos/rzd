import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/profile/model/faq_info.dart';
import 'package:rzd/features/profile/repository/faq_repository.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  FaqBloc() : super(FaqEmpty()) {
    on<GetFaqs>((event, emit) async {
      try {
        final list = await FaqRepository().getFaqs();
        emit(FaqInitial(faqs: list));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
