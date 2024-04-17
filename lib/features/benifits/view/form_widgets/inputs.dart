import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/validators.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/auth/view/widget/input_form.dart';
import 'package:rzd/features/home/view/widget/bottom_select.dart';
import 'package:file_picker/file_picker.dart';
import 'titles.dart';

class FilePickerButton extends StatelessWidget {
  FilePickerButton({super.key, required this.file, required this.onTap});

  final Function? onTap;
  File? file;

  @override
  Widget build(BuildContext context) {
    return ContainerButton(
      text: 'Выбрать файлы',
      color: ColorsUI.inactiveRedLight,
      textColor: ColorsUI.activeRed,
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'doc']);
        if (result != null) {
          file = File(result.files.single.path!);
        }
        if (onTap != null) {
          onTap!();
        }
      },
    );
  }
}

class TextInputWithText extends StatelessWidget {
  const TextInputWithText(
      {super.key,
      this.type,
      required this.errorText,
      required this.controller,
      this.hintText,
      this.validator,
      this.isRequired = false,
      required this.subtitle});

  final String subtitle;
  final TextInputType? type;
  final String errorText;
  final TextEditingController controller;
  final String? hintText;
  final Validator? validator;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitleText(text: subtitle),
        const SizedBox(
          height: 8,
        ),
        InputForm(
          isRequired: isRequired,
          hintText: hintText ?? "",
          controller: controller,
          errorText: errorText,
          textInputType: type,
          validator: validator ?? NameValidator(),
        ),
      ],
    );
  }
}

class DateInputWithText extends StatelessWidget {
  const DateInputWithText(
      {super.key,
      this.type,
      required this.errorText,
      required this.controller,
      this.hintText,
      this.validator,
      required this.setState,
      required this.subtitle});

  final String subtitle;

  final TextInputType? type;
  final String errorText;
  final TextEditingController controller;
  final String? hintText;
  final Validator? validator;
  final Function setState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitleText(text: subtitle),
        const SizedBox(
          height: 8,
        ),
        InputForm(
          hintText: hintText ?? "",
          controller: controller,
          textInputType: TextInputType.datetime,
          validator: DateValidator(),
          errorText: errorText,
          trailing: GestureDetector(
              onTap: () async {
                DateTime? date = await showDatePicker(
                    locale: const Locale('ru', 'RU'),
                    context: context,
                    firstDate: DateTime(1940),
                    lastDate: DateTime.now());
                if (date != null) {
                  setState(() {
                    controller.text = DateFormat('dd.MM.yyyy').format(date);
                  });
                }
              },
              child: SvgPicture.asset('asset/icons/calendar_2.svg')),
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
            DateTextFormatter(),
          ],
        ),
      ],
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput(
      {super.key,
      this.type,
      required this.errorText,
      required this.controller,
      this.hintText,
      this.validator});

  final TextInputType? type;
  final String errorText;
  final TextEditingController controller;
  final String? hintText;
  final Validator? validator;

  @override
  Widget build(BuildContext context) {
    return InputForm(
      hintText: hintText ?? "",
      controller: controller,
      errorText: errorText,
      textInputType: type,
      validator: validator ?? NameValidator(),
    );
  }
}

class ChooseInput extends StatelessWidget {
  const ChooseInput({
    super.key,
    this.type,
    required this.errorText,
    required this.controller,
    this.hintText,
    this.validator,
    required this.chooses,
    this.svgTrailing,
    this.bottomTitleText,
    this.removeTrailing = false,
  });

  final TextInputType? type;
  final String errorText;
  final TextEditingController controller;
  final String? hintText;
  final Validator? validator;
  final List<String> chooses;
  final String? svgTrailing;

  final String? bottomTitleText;
  final bool removeTrailing;

  @override
  Widget build(BuildContext context) {
    return InputForm(
      hintText: hintText ?? "",
      controller: controller,
      errorText: errorText,
      textInputType: type,
      readOnly: true,
      validator: validator ?? NameValidator(),
      onTap: () async {
        controller.text =
            await showBottomSelect(context, chooses, bottomTitleText) ?? '';
      },
      trailing: !removeTrailing
          ? GestureDetector(
              onTap: () async {
                controller.text =
                    await showBottomSelect(context, chooses, bottomTitleText) ??
                        '';
              },
              child: SvgPicture.asset(
                  svgTrailing ?? 'asset/icons/arrow_bottom.svg'),
            )
          : null,
    );
  }
}

class DateInput extends StatelessWidget {
  const DateInput(
      {super.key,
      this.type,
      required this.errorText,
      required this.controller,
      this.hintText,
      this.validator,
      required this.setState});

  final TextInputType? type;
  final String errorText;
  final TextEditingController controller;
  final String? hintText;
  final Validator? validator;
  final Function setState;

  @override
  Widget build(BuildContext context) {
    return InputForm(
      hintText: hintText ?? "",
      controller: controller,
      textInputType: TextInputType.datetime,
      validator: DateValidator(),
      errorText: errorText,
      trailing: GestureDetector(
          onTap: () async {
            DateTime? date = await showDatePicker(
                locale: const Locale('ru', 'RU'),
                context: context,
                firstDate: DateTime(1940),
                lastDate: DateTime.now());
            if (date != null) {
              setState(() {
                controller.text = DateFormat('dd.MM.yyyy').format(date);
              });
            }
          },
          child: SvgPicture.asset('asset/icons/calendar_2.svg')),
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        DateTextFormatter(),
      ],
    );
  }
}
