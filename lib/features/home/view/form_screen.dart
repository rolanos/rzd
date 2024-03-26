import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/model/form_data_class.dart';
import 'package:rzd/core/validators.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/auth/view/widget/input_form.dart';
import 'package:rzd/features/home/view/bloc/bloc/form_bloc.dart';
import 'package:rzd/features/menu/app_bar.dart';

import 'widget/title_text.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+7 ### ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    initialText: '+7 ',
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormBlocState>(
      builder: (context, state) {
        if (state is FormInitial) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNotificationsAppBar(
                  appbarText: state.form?.statusName ?? '',
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ColorsUI.mainWhite,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleText('Заполните форму'),
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
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => TextInput(
                            formDescription:
                                state.form?.formDescription[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: state.form?.formDescription.length ?? 0,
                      ),
                      if (state.form?.allowFiles == true)
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText('Документы'),
                            SizedBox(height: 10),
                            ContainerButton(
                              text: 'Выбрать файлы',
                              color: ColorsUI.inactiveRedLight,
                            ),
                            SizedBox(height: 20),
                            Row(
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
                          ],
                        ),
                      const SizedBox(height: 20),
                      const ContainerButton(
                        text: 'Отправить',
                        textColor: ColorsUI.mainWhite,
                        color: ColorsUI.activeRed,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput({super.key, required this.formDescription});

  final FormDescription? formDescription;

  @override
  Widget build(BuildContext context) {
    if (formDescription == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(formDescription?.title ?? '-'),
        const SizedBox(height: 10),
        if (formDescription?.type != null)
          SelectInput(formDescription: formDescription, context: context),
      ],
    );
  }
}

class SelectInput extends StatefulWidget {
  const SelectInput({super.key, this.formDescription, required this.context});

  final FormDescription? formDescription;
  final BuildContext context;

  @override
  State<SelectInput> createState() => _SelectInputState();
}

class _SelectInputState extends State<SelectInput> {
  @override
  Widget build(BuildContext context) {
    switch (widget.formDescription?.type) {
      case 'select':
        return InputForm(
          hintText: 'Выберите',
          controller:
              widget.formDescription?.controller ?? TextEditingController(),
        );
      case 'date':
        return InputForm(
          hintText: 'Выберите дату',
          controller:
              widget.formDescription?.controller ?? TextEditingController(),
          textInputType: TextInputType.datetime,
          validator: DateValidator(),
          errorText: 'Укажите дату',
          trailing: GestureDetector(
              onTap: () async {
                DateTime? date = await showDatePicker(
                    locale: const Locale('ru', 'RU'),
                    context: context,
                    firstDate: DateTime(1940),
                    lastDate: DateTime.now());
                if (date != null) {
                  widget.formDescription?.controller.text =
                      DateFormat('dd.MM.yyyy').format(date);
                  setState(() {});
                }
              },
              child: SvgPicture.asset('asset/icons/calendar_2.svg')),
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
            DateTextFormatter(),
          ],
        );
      case 'text':
        return InputForm(
          hintText: '',
          controller:
              widget.formDescription?.controller ?? TextEditingController(),
        );

      default:
        return const SizedBox();
    }
  }
}
