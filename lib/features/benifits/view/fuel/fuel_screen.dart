import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/extensions.dart';
import 'package:rzd/core/validators.dart';
import 'package:rzd/core/widget/add_info_container.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/benifits/model/fuel_form.dart';
import 'package:rzd/features/benifits/model/fuel_type.dart';
import 'package:rzd/features/benifits/view/form_widgets/check_boxs.dart';
import 'package:rzd/features/benifits/view/form_widgets/content_container.dart';
import 'package:rzd/features/benifits/view/form_widgets/inputs.dart';
import 'package:rzd/features/benifits/view/form_widgets/titles.dart';
import 'package:rzd/features/benifits/view/fuel/bloc/cubit/fuel_type_cubit.dart';
import 'package:rzd/features/benifits/view/fuel/bloc/fuel_bloc.dart';
import 'package:rzd/features/menu/app_bar.dart';

int searchfuelId(Map<int, String> values, String value) {
  for (var i = 0; i < values.length; i++) {
    if (values.values.toList()[i] == value) {
      return values.keys.toList()[i];
    }
  }
  return -1;
}

class FuelScreen extends StatefulWidget {
  const FuelScreen({super.key});

  @override
  State<FuelScreen> createState() => _FuelScreenState();
}

class _FuelScreenState extends State<FuelScreen> {
  final TextEditingController fuelNumberType = TextEditingController();
  final TextEditingController duration = TextEditingController();
  final TextEditingController wallMaterial = TextEditingController();
  final TextEditingController humanCount = TextEditingController();
  final TextEditingController heatedArea = TextEditingController();
  final TextEditingController mainPhone = TextEditingController();
  final TextEditingController additionalPhone = TextEditingController();
  final TextEditingController comment = TextEditingController();

  bool fuelTypeCheckbox1 = false;
  bool fuelTypeCheckbox2 = false;
  bool fuelIsCheched = true;

  bool placeForGettingCheckbox1 = false;
  bool placeForGettingCheckbox2 = false;
  bool placeForGettingCheched = true;

  bool usedForCheckbox1 = false;
  bool usedForCheckbox2 = false;
  bool usedForCheckbox3 = false;

  bool notificationCheckbox1 = false;
  bool notificationCheckbox2 = false;
  bool notificationChecked = true;

  bool approveCheckbox1 = false;
  bool isApproved1 = true;

  bool approveCheckbox2 = false;
  bool isApproved2 = true;

  File? file;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          const CustomNotificationsAppBar(
              appbarText: "Обеспечение бытовым топливом"),
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
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      const SubTitleText(text: 'Тип топлива:'),
                      CircleCheckBox(
                        text: 'Уголь',
                        isRedText: !fuelIsCheched,
                        isChecked: fuelTypeCheckbox1,
                        onTap: () => setState(
                          () {
                            fuelTypeCheckbox1 = !fuelTypeCheckbox1;
                            if (fuelTypeCheckbox2) {
                              fuelTypeCheckbox2 = false;
                            }
                          },
                        ),
                      ),
                      CircleCheckBox(
                        text: 'Дрова',
                        isRedText: !fuelIsCheched,
                        isChecked: fuelTypeCheckbox2,
                        onTap: () => setState(
                          () {
                            fuelTypeCheckbox2 = !fuelTypeCheckbox2;
                            if (fuelTypeCheckbox1) {
                              fuelTypeCheckbox1 = false;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      const SubTitleText(text: 'Место получения:'),
                      CircleCheckBox(
                        text: 'Склад ОАО «РЖД»',
                        isRedText: !placeForGettingCheched,
                        isChecked: placeForGettingCheckbox1,
                        onTap: () => setState(
                          () {
                            placeForGettingCheckbox1 =
                                !placeForGettingCheckbox1;
                            if (placeForGettingCheckbox2) {
                              placeForGettingCheckbox2 = false;
                            }
                          },
                        ),
                      ),
                      CircleCheckBox(
                        text: 'ГОРТОП',
                        isChecked: placeForGettingCheckbox2,
                        isRedText: !placeForGettingCheched,
                        onTap: () => setState(
                          () {
                            placeForGettingCheckbox2 =
                                !placeForGettingCheckbox2;
                            if (placeForGettingCheckbox1) {
                              placeForGettingCheckbox1 = false;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SubTitleText(text: 'Вид топлива:'),
                  const SizedBox(height: 10),
                  BlocBuilder<FuelTypeCubit, FuelTypeState>(
                    builder: (context, state) {
                      if (state is FuelTypeInitial) {
                        return ChooseInput(
                          errorText: '',
                          hintText: 'Выберите',
                          bottomTitleText: 'Выберите вид топлива',
                          controller: fuelNumberType,
                          chooses: state.fuels.values.toList(),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  DateInputWithText(
                    errorText: '',
                    controller: duration,
                    setState: setState,
                    subtitle: 'Период получения услуги:',
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      const SubTitleText(text: 'Для чего используется:'),
                      SqareCheckBox(
                        text: 'Отопление',
                        isChecked: usedForCheckbox1,
                        onTap: () => setState(
                          () {
                            usedForCheckbox1 = !usedForCheckbox1;
                          },
                        ),
                      ),
                      SqareCheckBox(
                        text: 'Приготовление пищи',
                        isChecked: usedForCheckbox2,
                        onTap: () => setState(
                          () {
                            usedForCheckbox2 = !usedForCheckbox2;
                          },
                        ),
                      ),
                      SqareCheckBox(
                        text: 'ГВС',
                        isChecked: usedForCheckbox3,
                        onTap: () => setState(
                          () {
                            usedForCheckbox3 = !usedForCheckbox3;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SubTitleText(text: 'Материал стен:'),
                  const SizedBox(height: 10),
                  ChooseInput(
                    errorText: '',
                    bottomTitleText: 'Выберите материал стен',
                    controller: wallMaterial,
                    chooses: const ['Дерево', 'Крипич'],
                    hintText: 'Выберите',
                  ),
                  const SizedBox(height: 20),
                  TextInputWithText(
                    errorText: '',
                    controller: humanCount,
                    isRequired: true,
                    hintText: 'Количество человек',
                    subtitle: 'Всего проживает человек:',
                  ),
                  const SizedBox(height: 20),
                  TextInputWithText(
                    errorText: '',
                    controller: heatedArea,
                    isRequired: true,
                    hintText: 'Укажите количество м2',
                    subtitle: 'Отапливаемая площадь:',
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      const SubTitleText(text: 'Уведомления'),
                      CircleCheckBox(
                        text: 'Электронной почтой или по телефону',
                        isChecked: notificationCheckbox1,
                        isRedText: !notificationChecked,
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
                        isChecked: notificationCheckbox2,
                        isRedText: !notificationChecked,
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
                  const SizedBox(height: 20),
                  TextInputWithText(
                    errorText: '',
                    controller: comment,
                    hintText: 'По желанию',
                    subtitle: 'Комментарий',
                  ),
                  const SizedBox(height: 20),
                  const SubTitleText(text: 'Приложите документы'),
                  const SizedBox(height: 10),
                  if (file != null)
                    ContentText(text: file?.path.parseDocumentPath() ?? '-'),
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
                  const ContentText(
                    text:
                        '''К заявке должны быть приложены копии официальных документов сроком действия не более 60 дней (за исключением документов без срока действия), подтверждающие следующие данные:
постоянная регистрация (прописка) благополучателя;
наличие индивидуальной системы отопления и (или) печного кухонного очага, и (или) индивидуальной системы горячего водоснабжения на твердом топливе по адресу постоянной регистрации благополучателя;
сведения о материале стен дома (квартиры);
размер общей отапливаемой площади жилого помещения дома (квартиры);
сведения о членах семьи проживающих совместно с благополучателем;
сведения о нахождении на учете по обеспечению бытовым топливом членов семьи (если они являются работниками, неработающими пенсионерами ОАО «РЖД» или работниками, неработающими пенсионерами РОСПРОФЖЕЛ).
Рекомендуемые виды подтверждающих документов: выписка из домовой книги, справка из соответствующего органа муниципального образования, справка с места жительства, технический паспорт жилого помещения, другие официальные документы;''',
                    textColor: ColorsUI.borderColor,
                  ),
                  const SizedBox(height: 20),
                  SqareCheckBox(
                    isRedText: !isApproved1,
                    text:
                        'Подтверждаю, что члены моей семьи не получают данную услугу',
                    isChecked: approveCheckbox1,
                    onTap: () =>
                        setState(() => approveCheckbox1 = !approveCheckbox1),
                  ),
                  const SizedBox(height: 20),
                  SqareCheckBox(
                    isRedText: !isApproved2,
                    text:
                        'Я подтверждаю свое согласие на получение (в соответствии с действующим Колективным договором ОАО "РЖД") компенсации за бытовое топливо.',
                    isChecked: approveCheckbox2,
                    onTap: () =>
                        setState(() => approveCheckbox2 = !approveCheckbox2),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<FuelTypeCubit, FuelTypeState>(
                    builder: (context, fuelTypeState) {
                      if (fuelTypeState is FuelTypeInitial) {
                        return BlocConsumer<FuelBloc, FuelState>(
                          listener: (context, state) {
                            if (state is FuelSended) {
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
                                if (approveCheckbox1) {
                                  isApproved1 = true;
                                } else {
                                  isApproved1 = false;
                                }
                                if (approveCheckbox2) {
                                  isApproved2 = true;
                                } else {
                                  isApproved2 = false;
                                }
                                if (fuelTypeCheckbox1 || fuelTypeCheckbox2) {
                                  fuelIsCheched = true;
                                } else {
                                  fuelIsCheched = false;
                                }
                                if (placeForGettingCheckbox1 ||
                                    placeForGettingCheckbox2) {
                                  placeForGettingCheched = true;
                                } else {
                                  placeForGettingCheched = false;
                                }
                                if (notificationCheckbox1 ||
                                    notificationCheckbox2) {
                                  notificationChecked = true;
                                } else {
                                  notificationChecked = false;
                                }

                                setState(() {});
                                if (formKey.currentState?.validate() == true &&
                                    fuelIsCheched &&
                                    placeForGettingCheched &&
                                    notificationChecked &&
                                    isApproved1 &&
                                    isApproved2) {
                                  String resString = '';
                                  final res = file?.readAsBytesSync();
                                  if (res != null) {
                                    resString = base64Encode(res.toList());
                                  }

                                  FuelForm fuelForm = FuelForm(
                                    delivery: false,
                                    wall: wallMaterial.text == 'Дерево'
                                        ? true
                                        : false,
                                    fuel_type: searchfuelId(fuelTypeState.fuels,
                                        fuelNumberType.text),
                                    person_count: int.parse(humanCount.text),
                                    area: int.parse(heatedArea.text),
                                    cooking: usedForCheckbox1,
                                    water: usedForCheckbox2,
                                    year: int.parse('2024'),
                                    address: '',
                                    mobile_phone: mainPhone.text,
                                    home_phone: additionalPhone.text,
                                    comment: comment.text,
                                    filename: resString,
                                  );
                                  context
                                      .read<FuelBloc>()
                                      .add(FuelSend(fuelForm: fuelForm));
                                }
                              },
                              text: state is! FuelSendLoading
                                  ? 'Отправить'
                                  : 'Отправка...',
                              color: state is! FuelSendLoading
                                  ? ColorsUI.activeRed
                                  : ColorsUI.inactiveRedLight,
                              textColor: state is! FuelSendLoading
                                  ? ColorsUI.mainWhite
                                  : ColorsUI.activeRed,
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
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
