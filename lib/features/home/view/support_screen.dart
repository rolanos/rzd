import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/validators.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/auth/view/widget/input_form.dart';
import 'package:rzd/features/benifits/view/form_widgets/titles.dart';
import 'package:rzd/features/home/view/bloc/bloc/support_bloc.dart';
import 'package:rzd/features/menu/app_bar.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController topic = TextEditingController();
  final TextEditingController request = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? file;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupportBloc, SupportState>(
      listener: (context, state) {
        if (state is SupportSended) {
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
        return SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                appbarText: 'Форма для обратной связи',
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ColorsUI.mainWhite,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Заполните форму',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ColorsUI.otpBorder,
                          fontSize: 20,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorsUI.containerBackground,
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: RichText(
                                text: const TextSpan(
                                  text:
                                      'Если у Вас возникли вопросы, обратитесь на Горячую линию (ИКЦ) по телефонам ',
                                  children: [
                                    TextSpan(
                                      text: '8 800 775 95 97',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: ColorsUI.otpBorder,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' и ',
                                    ),
                                    TextSpan(
                                      text: '1810',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: ColorsUI.otpBorder,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' (с мобильного телефона). Звонок бесплатный. Режим работы: с 02:00 до 18:00 пн-пт (мск).',
                                    ),
                                  ],
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: ColorsUI.otpBorder,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Тема обращения',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorsUI.otpBorder,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InputForm(
                        hintText: 'Введите тему',
                        validator: NameValidator(),
                        controller: topic,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Обращение',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorsUI.otpBorder,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InputForm(
                        hintText: '',
                        validator: NameValidator(),
                        controller: request,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Документы',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorsUI.otpBorder,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (file != null) ContentText(text: file?.path ?? '-'),
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
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Flexible(
                            child: Text(
                              '''1. Размер загружаемого файла после сжатия не должен превышать 5 Мб.
2. В имени прикладываемого файла должно быть не более 100 символов.
3. Общее количество загружаемых файлов не должно превышать 3.
4. Общий размер комплекта со всеми вложениями не должен превышать 10 Мб.''',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter',
                                color: ColorsUI.borderColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ContainerButton(
                        text: state is SupportSendLoading
                            ? 'Отправка'
                            : 'Отправить',
                        onTap: () {
                          if (formKey.currentState?.validate() == true) {
                            if (state is! SupportSendLoading) {
                              context.read<SupportBloc>().add(
                                    SupportSend(
                                      topic: topic.text,
                                      body: request.text,
                                      doc: file,
                                    ),
                                  );
                            }
                          }
                        },
                        textColor: state is SupportSendLoading
                            ? ColorsUI.activeRed
                            : ColorsUI.mainWhite,
                        color: state is SupportSendLoading
                            ? ColorsUI.inactiveRedLight
                            : ColorsUI.activeRed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
