import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/extensions.dart';
import 'package:rzd/core/widget/add_info_container.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/benifits/model/teeth_form.dart';
import 'package:rzd/features/benifits/view/form_widgets/check_boxs.dart';
import 'package:rzd/features/benifits/view/form_widgets/content_container.dart';
import 'package:rzd/features/benifits/view/form_widgets/inputs.dart';
import 'package:rzd/features/benifits/view/form_widgets/titles.dart';
import 'package:rzd/features/benifits/view/teeth/bloc/teeth_bloc.dart';
import 'package:rzd/features/menu/app_bar.dart';

int? searchOrganizationId(Map<String, dynamic> values, String value) {
  for (var i = 0; i < values.length; i++) {
    if (values.values.toList()[i] == value) {
      return int.parse(values.keys.toList()[i]);
    }
  }
  return null;
}

class TeethScreen extends StatefulWidget {
  const TeethScreen({super.key});

  @override
  State<TeethScreen> createState() => _TeethScreenState();
}

class _TeethScreenState extends State<TeethScreen> {
  final TextEditingController serviceType = TextEditingController();

  final TextEditingController mainPhone = TextEditingController();
  final TextEditingController additionalPhone = TextEditingController();
  final TextEditingController comment = TextEditingController();

  File? document_contract;
  File? document_act;
  File? document_tickets;
  File? documenadst_act;
  File? document_other;

  bool methodForGetCheckbox1 = true;
  bool methodForGetCheckbox2 = false;
  bool methodForGetChecked = true;

  bool notificationCheckbox1 = false;
  bool notificationCheckbox2 = false;
  bool notificationChecked = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          const CustomNotificationsAppBar(
              appbarText: "Изготовление и ремонт зубных протезов"),
          const ContentContainer(
            child: Wrap(
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                MainTitleText(text: 'Заполните форму'),
                ContentText(
                    text:
                        'Если у Вас возникли вопросы по заполнению формы обращения, обратитесь в Информационно-консультационный центр по телефону 8(800) 775-95-97 или на короткий номер 1810 с моб.телефона (звонки бесплатные) (режим работы с 02:00 до 18:00 пн-пт (МСК))'),
                AdditionalInfoContainer(),
              ],
            ),
          ),
          ContentContainer(
            child: Wrap(
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                const SubTitleText(text: 'Cпособ получения услуги:'),
                CircleCheckBox(
                  text: 'В лечебном учреждении в ОАО "РЖД"',
                  isRedText: !methodForGetChecked,
                  isChecked: methodForGetCheckbox1,
                  onTap: () => setState(
                    () {
                      methodForGetCheckbox1 = !methodForGetCheckbox1;
                      if (methodForGetCheckbox2) {
                        methodForGetCheckbox2 = false;
                      }
                    },
                  ),
                ),
                CircleCheckBox(
                  text:
                      'Компенсация в ином лицензированном медицинском учреждении',
                  isRedText: !methodForGetChecked,
                  isChecked: methodForGetCheckbox2,
                  onTap: () => setState(
                    () {
                      methodForGetCheckbox2 = !methodForGetCheckbox2;
                      if (methodForGetCheckbox1) {
                        methodForGetCheckbox1 = false;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          ContentContainer(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (methodForGetCheckbox1)
                    const SubTitleText(text: 'Лечебное учреждение:'),
                  if (methodForGetCheckbox1) const SizedBox(height: 10),
                  if (methodForGetCheckbox1)
                    BlocBuilder<TeethBloc, TeethState>(
                      buildWhen: (previous, current) {
                        if (current is TeethSended ||
                            current is TeethSendLoading) {
                          return false;
                        }
                        return true;
                      },
                      builder: (context, state) {
                        if (state is TeethInitial) {
                          return ChooseInput(
                            errorText: '',
                            controller: serviceType,
                            bottomTitleText: 'Выберите лечебное учреждение',
                            chooses: List.generate(
                              state.services.values.length,
                              (index) => state.services.values
                                  .toList()[index]
                                  .toString(),
                            ),
                            hintText: 'Выберите',
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  const SizedBox(height: 20),
                  Wrap(
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      const SubTitleText(text: 'Уведомления'),
                      CircleCheckBox(
                        text: 'Электронной почтой или по телефону',
                        isRedText: !notificationChecked,
                        isChecked: notificationCheckbox1,
                        onTap: () => setState(
                          () {
                            notificationCheckbox1 = !notificationCheckbox1;
                            if (notificationCheckbox2) {
                              notificationCheckbox2 = false;
                            }
                          },
                        ),
                      ),
                      CircleCheckBox(
                        text: 'Через личный кабинет',
                        isRedText: !methodForGetChecked,
                        isChecked: notificationCheckbox2,
                        onTap: () => setState(
                          () {
                            notificationCheckbox2 = !notificationCheckbox2;
                            if (notificationCheckbox1) {
                              notificationCheckbox1 = false;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (methodForGetCheckbox2)
                    const SubTitleText(text: 'Договор с мед. учреждением'),
                  if (methodForGetCheckbox2) const SizedBox(height: 10),
                  if (methodForGetCheckbox2)
                    ContainerFilePicker(
                      text: document_contract != null
                          ? document_contract?.path.parseDocumentPath() ?? ''
                          : 'Выбрать файл',
                      color: document_contract != null
                          ? ColorsUI.containerBackground
                          : ColorsUI.inactiveRedLight,
                      textColor: document_contract != null
                          ? ColorsUI.mainText
                          : ColorsUI.activeRed,
                      trailing: document_contract != null
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  document_contract = null;
                                });
                              },
                              child: SvgPicture.asset(
                                'asset/icons/delete.svg',
                                width: 16,
                                height: 18,
                              ),
                            )
                          : null,
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'pdf', 'doc']);
                        if (result != null) {
                          document_contract = File(result.files.single.path!);
                        }
                        setState(() {});
                      },
                    ),
                  if (methodForGetCheckbox2) const SizedBox(height: 20),
                  if (methodForGetCheckbox2)
                    const SubTitleText(text: 'Акт выполненных работ'),
                  if (methodForGetCheckbox2) const SizedBox(height: 10),
                  if (methodForGetCheckbox2)
                    ContainerFilePicker(
                      text: document_act != null
                          ? document_act?.path.parseDocumentPath() ?? ''
                          : 'Выбрать файл',
                      color: document_act != null
                          ? ColorsUI.containerBackground
                          : ColorsUI.inactiveRedLight,
                      textColor: document_act != null
                          ? ColorsUI.mainText
                          : ColorsUI.activeRed,
                      trailing: document_act != null
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  document_act = null;
                                });
                              },
                              child: SvgPicture.asset(
                                'asset/icons/delete.svg',
                                width: 16,
                                height: 18,
                              ),
                            )
                          : null,
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'pdf', 'doc']);
                        if (result != null) {
                          document_act = File(result.files.single.path!);
                        }
                        setState(() {});
                      },
                    ),
                  if (methodForGetCheckbox2) const SizedBox(height: 20),
                  if (methodForGetCheckbox2)
                    const SubTitleText(
                        text:
                            'Чеки или другие документы, подтверждающие оплату'),
                  if (methodForGetCheckbox2) const SizedBox(height: 10),
                  if (methodForGetCheckbox2)
                    ContainerFilePicker(
                      text: document_tickets != null
                          ? document_tickets?.path.parseDocumentPath() ?? ''
                          : 'Выбрать файл',
                      color: document_tickets != null
                          ? ColorsUI.containerBackground
                          : ColorsUI.inactiveRedLight,
                      textColor: document_tickets != null
                          ? ColorsUI.mainText
                          : ColorsUI.activeRed,
                      trailing: document_tickets != null
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  document_tickets = null;
                                });
                              },
                              child: SvgPicture.asset(
                                'asset/icons/delete.svg',
                                width: 16,
                                height: 18,
                              ),
                            )
                          : null,
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'pdf', 'doc']);
                        if (result != null) {
                          document_tickets = File(result.files.single.path!);
                        }
                        setState(() {});
                      },
                    ),
                  if (methodForGetCheckbox2) const SizedBox(height: 20),
                  if (methodForGetCheckbox2)
                    const SubTitleText(
                        text: 'Другой документ (при необходимости)'),
                  if (methodForGetCheckbox2) const SizedBox(height: 10),
                  if (methodForGetCheckbox2)
                    ContainerFilePicker(
                      text: document_other != null
                          ? document_other?.path.parseDocumentPath() ?? ''
                          : 'Выбрать файл',
                      color: document_other != null
                          ? ColorsUI.containerBackground
                          : ColorsUI.inactiveRedLight,
                      textColor: document_other != null
                          ? ColorsUI.mainText
                          : ColorsUI.activeRed,
                      trailing: document_other != null
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  document_other = null;
                                });
                              },
                              child: SvgPicture.asset(
                                'asset/icons/delete.svg',
                                width: 16,
                                height: 18,
                              ),
                            )
                          : null,
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'pdf', 'doc']);
                        if (result != null) {
                          document_other = File(result.files.single.path!);
                        }
                        setState(() {});
                      },
                    ),
                  const SizedBox(height: 20),
                  if (methodForGetCheckbox1)
                    Wrap(
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        const SubTitleText(text: 'Телефоны для связи'),
                        TextInput(
                          errorText: '',
                          hintText: 'Основной',
                          controller: mainPhone,
                        ),
                        TextInput(
                          errorText: '',
                          hintText: 'Дополнительный',
                          controller: additionalPhone,
                        ),
                      ],
                    ),
                  if (methodForGetCheckbox1) const SizedBox(height: 20),
                  TextInputWithText(
                    errorText: '',
                    controller: comment,
                    hintText: 'По желанию',
                    subtitle: 'Комментарий',
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<TeethBloc, TeethState>(
                    listener: (context, state) {
                      if (state is TeethSendLoading) {
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
                          setState(() {});
                          if (methodForGetCheckbox1 || methodForGetCheckbox2) {
                            methodForGetChecked = true;
                          } else {
                            methodForGetChecked = false;
                          }
                          if (notificationCheckbox1 || notificationCheckbox2) {
                            notificationChecked = true;
                          } else {
                            notificationChecked = false;
                          }
                          setState(() {});
                          if (formKey.currentState?.validate() == true &&
                              methodForGetChecked &&
                              notificationChecked) {
                            int? chuzIndex = -1;
                            if (state is TeethInitial) {
                              chuzIndex = searchOrganizationId(
                                  state.services, serviceType.text);
                            }
                            TeethForm teethForm = TeethForm(
                              type_service: methodForGetCheckbox1
                                  ? 'chuz'
                                  : 'compensation',
                              chuz: chuzIndex,
                              mobile_phone: mainPhone.text.isNotEmpty
                                  ? mainPhone.text
                                  : null,
                              home_phone: additionalPhone.text.isNotEmpty
                                  ? additionalPhone.text
                                  : null,
                              comment:
                                  comment.text.isNotEmpty ? comment.text : null,
                              medicalSertificate: null,
                              documentContract: document_contract,
                              documentAct: documenadst_act,
                              documentTickets: document_tickets,
                              documentOther: document_other,
                            );
                            context
                                .read<TeethBloc>()
                                .add(TeethSend(teethForm: teethForm));
                          }
                        },
                        text: state is! TeethSendLoading
                            ? 'Отправить'
                            : 'Отправка...',
                        color: state is! TeethSendLoading
                            ? ColorsUI.activeRed
                            : ColorsUI.inactiveRedLight,
                        textColor: state is! TeethSendLoading
                            ? ColorsUI.mainWhite
                            : ColorsUI.activeRed,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
