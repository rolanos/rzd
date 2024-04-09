part of 'documents_cubit.dart';

sealed class DocumentsState extends Equatable {
  const DocumentsState();

  @override
  List<Object> get props => [];
}

final class DocumentsEmpty extends DocumentsState {}

final class DocumentsInitial extends DocumentsState {
  final List<AppDocument> documents;

  const DocumentsInitial({required this.documents});
}
