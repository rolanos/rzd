import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/validators.dart';
import 'package:rzd/core/widget/add_info_container.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/benifits/view/form_widgets/check_boxs.dart';
import 'package:rzd/features/benifits/view/form_widgets/content_container.dart';
import 'package:rzd/features/benifits/view/form_widgets/inputs.dart';
import 'package:rzd/features/benifits/view/form_widgets/titles.dart';
import 'package:rzd/features/menu/app_bar.dart';

class FuelScreen extends StatefulWidget {
  const FuelScreen({super.key});

  @override
  State<FuelScreen> createState() => _FuelScreenState();
}

class _FuelScreenState extends State<FuelScreen> {
  final TextEditingController fuelNumberType = TextEditingController();
  final TextEditingController wallMaterial = TextEditingController();
  final TextEditingController humanCount = TextEditingController();
  final TextEditingController heatedArea = TextEditingController();
  final TextEditingController mainPhone = TextEditingController();
  final TextEditingController additionalPhone = TextEditingController();
  final TextEditingController comment = TextEditingController();

  bool fuelTypeCheckbox1 = false;
  bool fuelTypeCheckbox2 = false;

  bool usedForCheckbox1 = false;
  bool usedForCheckbox2 = false;
  bool usedForCheckbox3 = false;

  bool notificationCheckbox1 = false;
  bool notificationCheckbox2 = false;

  bool approveCheckbox1 = false;

  bool approveCheckbox2 = false;

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
                          },
                        ),
                      ),
                      CircleCheckBox(
                        text: 'Дрова',
                        isChecked: fuelTypeCheckbox1,
                        onTap: () => setState(
                          () {
                            fuelTypeCheckbox1 = !fuelTypeCheckbox1;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextInput(
                    errorText: '',
                    hintText: 'Выберите',
                    controller: fuelNumberType,
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      SqareCheckBox(
                        text: 'Отопление',
                        isChecked: usedForCheckbox1,
                        onTap: () => setState(
                          () {
                            fuelTypeCheckbox1 = !fuelTypeCheckbox1;
                          },
                        ),
                      ),
                      SqareCheckBox(
                        text: 'Приготовление пищи',
                        isChecked: usedForCheckbox1,
                        onTap: () => setState(
                          () {
                            fuelTypeCheckbox1 = !fuelTypeCheckbox1;
                          },
                        ),
                      ),
                      SqareCheckBox(
                        text: 'ГВС',
                        isChecked: usedForCheckbox1,
                        onTap: () => setState(
                          () {
                            fuelTypeCheckbox1 = !fuelTypeCheckbox1;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextInputWithText(
                    errorText: '',
                    controller: wallMaterial,
                    hintText: 'Выберите',
                    subtitle: 'Материал стен:',
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
                    controller: humanCount,
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
                          },
                        ),
                      ),
                      CircleCheckBox(
                        text: 'Через личный кабинет',
                        isChecked: notificationCheckbox2,
                        onTap: () => setState(
                          () {
                            notificationCheckbox2 = !notificationCheckbox2;
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
                      const SubTitleText(text: 'Уведомления'),
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
                  const ContainerButton(
                    text: 'Выбрать файлы',
                    color: ColorsUI.inactiveRedLight,
                    textColor: ColorsUI.activeRed,
                  ),
                  const SizedBox(height: 10),
                  const ContentText(
                    text: '',
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
                        'Я подтверждаю свое согласие  на получение (в соответствии с действующим Колективным договором ОАО "РЖД") компенсации за бытовое топливо.',
                    isChecked: approveCheckbox1,
                    onTap: () =>
                        setState(() => approveCheckbox1 = !approveCheckbox1),
                  ),
                  const SizedBox(height: 20),
                  ContainerButton(
                    onTap: () {},
                    text: 'Отправить',
                    color: ColorsUI.activeRed,
                    textColor: ColorsUI.mainWhite,
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
