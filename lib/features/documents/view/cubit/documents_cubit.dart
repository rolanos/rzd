import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rzd/features/documents/model/app_document.dart';
import 'package:rzd/features/documents/repository/document_repository.dart';

part 'documents_state.dart';

class DocumentsCubit extends Cubit<DocumentsState> {
  DocumentsCubit() : super(DocumentsEmpty());

  getDocuments() async {
    try {
      emit(DocumentsInitial(
          documents: await DocumentRepository().getFileList()));
    } catch (e) {
      log(e.toString());
    }
  }

  getDocument(int id) async {
    try {
      await DocumentRepository().getSingleFile(id);
    } catch (e) {
      log(e.toString());
    }
  }
}
