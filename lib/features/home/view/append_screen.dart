import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/extensions.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/benifits/view/form_widgets/inputs.dart';
import 'package:rzd/features/benifits/view/form_widgets/titles.dart';
import 'package:rzd/features/home/view/bloc/bloc/append_bloc.dart';
import 'package:rzd/features/menu/app_bar.dart';

class AppendScreen extends StatefulWidget {
  AppendScreen({super.key, required this.appBarTitle});

  final String appBarTitle;
  final TextEditingController application = TextEditingController();
  final TextEditingController comment = TextEditingController();

  @override
  State<AppendScreen> createState() => _AppendScreenState();
}

class _AppendScreenState extends State<AppendScreen> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNotificationsAppBar(
            appbarText: widget.appBarTitle,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorsUI.mainWhite,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainTitleText(text: 'Добавление документов'),
                const SizedBox(height: 20),
                const SubTitleText(text: 'Куда добавить документы?'),
                const SizedBox(height: 10),
                BlocBuilder<AppendBloc, AppendState>(
                  builder: (context, state) {
                    if (state is AppendInitital) {
                      return ChooseInput(
                        errorText: '',
                        hintText: 'Выберите заявку',
                        controller: widget.application,
                        chooses: List.generate(state.appends.length,
                            (index) => state.appends[index].name),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(height: 20),
                const SubTitleText(text: 'Документы'),
                const SizedBox(height: 10),
                if (file != null)
                  ContentText(text: file?.path.parseDocumentPath() ?? '-'),
                const SizedBox(height: 6),
                ContainerButton(
                  text: 'Выбрать файлы',
                  color: ColorsUI.inactiveRedLight,
                  textColor: ColorsUI.activeRed,
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'pdf', 'doc']);
                    if (result != null) {
                      file = File(result.files.single.path!);
                    }
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                TextInputWithText(
                  errorText: '',
                  controller: widget.comment,
                  hintText: 'По желанию',
                  subtitle: 'Комментарий',
                ),
                const SizedBox(height: 20),
                BlocConsumer<AppendBloc, AppendState>(
                  listener: (context, state) {
                    if (state is AppendSended) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Center(
                            child: Text('Форма отправлена успешно'),
                          ),
                        ),
                      );
                      context.pop();
                    }
                  },
                  builder: (context, state) {
                    return ContainerButton(
                      onTap: () {
                        if (state is AppendSendLoading) {
                          return;
                        }
                        var id = '';
                        if (state is AppendInitital) {
                          id = state.appends
                              .firstWhere((element) =>
                                  element.name == widget.application.text)
                              .id;
                        }
                        if (widget.application.text.isEmpty) {
                          return;
                        }
                        context.read<AppendBloc>().add(
                              AppendSend(
                                id: id,
                                comment: widget.comment.text,
                                file: file,
                              ),
                            );
                      },
                      text: state is! AppendSendLoading
                          ? 'Отправить'
                          : 'Отправка...',
                      color: state is! AppendSendLoading
                          ? ColorsUI.activeRed
                          : ColorsUI.inactiveRedLight,
                      textColor: state is! AppendSendLoading
                          ? ColorsUI.mainWhite
                          : ColorsUI.activeRed,
                    );
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
