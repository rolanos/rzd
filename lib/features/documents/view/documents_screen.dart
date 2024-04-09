import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/documents/view/cubit/documents_cubit.dart';
import 'package:rzd/features/documents/view/widget/document_expansion.dart';
import 'package:rzd/features/menu/app_bar.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            appbarText: 'Нормативные документы',
          ),
          const SizedBox(
            height: 8,
          ),
          BlocBuilder<DocumentsCubit, DocumentsState>(
            builder: (context, state) {
              if (state is DocumentsInitial) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ColorsUI.mainWhite,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.documents.length,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => DocumentExpansion(
                      document: state.documents[index],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorsUI.activeRed,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
