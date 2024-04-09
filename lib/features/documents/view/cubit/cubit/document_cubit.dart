import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  DocumentCubit() : super(DocumentInitial());
}
