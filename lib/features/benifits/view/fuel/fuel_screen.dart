import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/validators.dart';
import 'package:rzd/core/widget/add_info_container.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/benifits/model/fuel_form.dart';
import 'package:rzd/features/benifits/view/form_widgets/check_boxs.dart';
import 'package:rzd/features/benifits/view/form_widgets/content_container.dart';
import 'package:rzd/features/benifits/view/form_widgets/inputs.dart';
import 'package:rzd/features/benifits/view/form_widgets/titles.dart';
import 'package:rzd/features/benifits/view/fuel/bloc/fuel_bloc.dart';
import 'package:rzd/features/menu/app_bar.dart';

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
  bool fuelIsCheched = false;

  bool placeForGettingCheckbox1 = false;
  bool placeForGettingCheckbox2 = false;
  bool placeForGettingCheched = false;

  bool usedForCheckbox1 = false;
  bool usedForCheckbox2 = false;
  bool usedForCheckbox3 = false;

  bool notificationCheckbox1 = false;
  bool notificationCheckbox2 = false;
  bool notificationChecked = false;

  bool approveCheckbox1 = false;

  bool approveCheckbox2 = false;

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
                  ChooseInput(
                    errorText: '',
                    hintText: 'Выберите',
                    controller: fuelNumberType,
                    chooses: const [
                      '92',
                      '95',
                      '98',
                    ],
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
                      SubTitleText(text: 'Для чего используется:'),
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
                    controller: wallMaterial,
                    chooses: ['Дерево', 'Крипич'],
                    hintText: 'Выберите',
                  ),
                  const SizedBox(height: 20),
                  TextInputWithText(
                    errorText: '',
                    controller: humanCount,
                    hintText: 'Количество человек',
                    subtitle: 'Всего проживает человек:',
                  ),
                  const SizedBox(height: 20),
                  TextInputWithText(
                    errorText: '',
                    controller: heatedArea,
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
                  FilePickerButton(
                    file: file,
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
                    text:
                        'Подтверждаю, что члены моей семьи не получают данную услугу',
                    isChecked: approveCheckbox1,
                    onTap: () =>
                        setState(() => approveCheckbox1 = !approveCheckbox1),
                  ),
                  const SizedBox(height: 20),
                  SqareCheckBox(
                    text:
                        'Я подтверждаю свое согласие на получение (в соответствии с действующим Колективным договором ОАО "РЖД") компенсации за бытовое топливо.',
                    isChecked: approveCheckbox2,
                    onTap: () =>
                        setState(() => approveCheckbox2 = !approveCheckbox2),
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<FuelBloc, FuelState>(
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
                          if (notificationCheckbox1 || notificationCheckbox1) {
                            notificationChecked = true;
                          } else {
                            notificationChecked = false;
                          }

                          setState(() {});
                          if (formKey.currentState?.validate() == true &&
                              fuelIsCheched &&
                              placeForGettingCheched &&
                              notificationChecked) {
                            FuelForm fuelForm = FuelForm(
                              delivery: false,
                              wall:
                                  wallMaterial.text == 'Дерево' ? true : false,
                              fuel_type: int.parse(fuelNumberType.text),
                              person_count: int.parse(humanCount.text),
                              area: int.parse(heatedArea.text),
                              cooking: usedForCheckbox1,
                              water: usedForCheckbox2,
                              year: int.parse('2024'),
                              address: '',
                              mobile_phone: mainPhone.text,
                              home_phone: additionalPhone.text,
                              comment: comment.text,
                              filename: file?.readAsStringSync(),
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
