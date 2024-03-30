import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/news/model/new_info.dart';
import 'package:rzd/features/news/repository/news_repository.dart';

part 'new_event.dart';
part 'new_state.dart';

class NewBloc extends Bloc<NewEvent, NewState> {
  NewBloc() : super(NewEmpty()) {
    on<GetNews>((event, emit) async {
      try {
        final result = await NewsRepository().getNews();
        emit(NewInitial(news: result));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
