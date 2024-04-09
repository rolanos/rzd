import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/documents/model/app_document.dart';
import 'package:rzd/features/documents/view/cubit/documents_cubit.dart';

class DocumentExpansion extends StatelessWidget {
  const DocumentExpansion({super.key, required this.document});

  final AppDocument document;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        trailing: const SizedBox(),
        tilePadding: const EdgeInsets.only(left: 8.0),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: Text(
                document.title ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorsUI.otpBorder,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SvgPicture.asset('asset/icons/arrow_bottom.svg'),
            ),
          ],
        ),
        children: [
          ListTile(
            title: Column(
              children: [
                Text(
                  document.description ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: ColorsUI.otpBorder,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 14),
                ContainerButton(
                  text: document.linkName ?? '-',
                  color: ColorsUI.inactiveRedLight,
                  textColor: ColorsUI.activeRed,
                  onTap: () {
                    context
                        .read<DocumentsCubit>()
                        .getDocument(document.documentId ?? 0);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
