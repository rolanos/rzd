import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/core/validators.dart';
import 'package:rzd/core/widget/add_info_container.dart';
import 'package:rzd/core/widget/container_button.dart';
import 'package:rzd/features/benifits/model/sankur_form.dart';
import 'package:rzd/features/benifits/view/form_widgets/check_boxs.dart';
import 'package:rzd/features/benifits/view/form_widgets/content_container.dart';
import 'package:rzd/features/benifits/view/form_widgets/inputs.dart';
import 'package:rzd/features/benifits/view/form_widgets/titles.dart';
import 'package:rzd/features/benifits/view/sankur/bloc/bloc/sankur_form_bloc.dart';
import 'package:rzd/features/benifits/view/sankur/bloc/bloc/sankur_objects_bloc.dart';
import 'package:rzd/features/benifits/view/sankur/bloc/rest_objects_bloc.dart';
import 'package:rzd/features/menu/app_bar.dart';

class SankurScreen extends StatefulWidget {
  const SankurScreen({super.key});

  @override
  State<SankurScreen> createState() => _SankurScreenState();
}

class _SankurScreenState extends State<SankurScreen> {
  final TextEditingController period = TextEditingController();
  final TextEditingController duration = TextEditingController();
  final TextEditingController acceptablePartSum = TextEditingController();

  final TextEditingController restObject = TextEditingController();
  final TextEditingController numberClass = TextEditingController();

  final TextEditingController mainPhone = TextEditingController();
  final TextEditingController additionalPhone = TextEditingController();

  final TextEditingController comment = TextEditingController();

  bool sqareCheckbox1 = false;
  bool sqareCheckbox2 = false;
  bool sqareCheckbox3 = false;
  bool sqareCheckbox4 = false;
  bool isCheckedSqareGroup = true;

  bool circleCheckbox1 = false;
  bool circleCheckbox2 = false;
  bool isCheckedCircleGroup = true;

  bool agreementCheckbox = false;
  bool isCheckedAgreement = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> months = const [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  final List<String> durationList = const [
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
  ];

  final List<String> classTypes = const [
    'Первая категория (стандарт)',
    'Вторая категория',
    'Третья категория',
    'Четвертая категория',
    'Пятая категория',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          const CustomNotificationsAppBar(
              appbarText: "Санаторно-курортное оздоровление и отдых"),
          const ContentContainer(
            child: Wrap(
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                MainTitleText(text: 'Заполните форму'),
                ContentText(
                  text:
                      'Если у Вас возникли вопросы по заполнению формы обращения, обратитесь в Информационно-консультационный центр по телефону 8(800) 775-95-97 или на короткий номер 1810 с моб.телефона (звонки бесплатные) (режим работы с 02:00 до 18:00 пн-пт (МСК))',
                ),
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
                  const SubTitleText(text: 'Период получения услуги:'),
                  const SizedBox(height: 8),
                  ChooseInput(
                    errorText: '',
                    controller: period,
                    svgTrailing: 'asset/icons/calendar_2.svg',
                    hintText: 'Выберите месяц',
                    type: TextInputType.number,
                    chooses: months,
                  ),
                  const SizedBox(height: 20),
                  const SubTitleText(text: 'Продолжительность путевки:'),
                  const SizedBox(height: 8),
                  ChooseInput(
                    errorText: '',
                    controller: duration,
                    hintText: 'Выберите',
                    type: TextInputType.number,
                    chooses: durationList,
                  ),
                  const SizedBox(height: 20),
                  TextInputWithText(
                    subtitle: 'Допустимая сумма частичной оплаты за путевку:',
                    errorText: '',
                    controller: acceptablePartSum,
                    type: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  const SubTitleText(text: 'Объект для отдыха'),
                  const SizedBox(height: 8),
                  BlocBuilder<RestObjectsBloc, RestObjectsState>(
                    builder: (context, state) {
                      if (state is RestObjectsInitial) {
                        return ChooseInput(
                          errorText: '',
                          controller: restObject,
                          hintText: 'Выберите',
                          type: TextInputType.number,
                          chooses: List.generate(
                            state.sanprofList.length,
                            (index) =>
                                state.sanprofList[index].name ??
                                "-Пустое значение-",
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 20),
                  const SubTitleText(text: 'Класс номера'),
                  const SizedBox(height: 8),
                  ChooseInput(
                    errorText: '',
                    controller: numberClass,
                    hintText: 'Выберите',
                    type: TextInputType.number,
                    chooses: classTypes,
                  ),
                  const SizedBox(height: 20),
                  const SubTitleText(
                      text:
                          'При отсутствии свободных мест согласен на изменение:'),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SqareCheckBox(
                        isRedText: !isCheckedSqareGroup,
                        text: 'Периода',
                        isChecked: sqareCheckbox1,
                        onTap: () => setState(
                          () {
                            sqareCheckbox1 = !sqareCheckbox1;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SqareCheckBox(
                        isRedText: !isCheckedSqareGroup,
                        text: 'Количества дней',
                        isChecked: sqareCheckbox2,
                        onTap: () => setState(
                          () {
                            sqareCheckbox2 = !sqareCheckbox2;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SqareCheckBox(
                        isRedText: !isCheckedSqareGroup,
                        text: 'Объекта для отдыха',
                        isChecked: sqareCheckbox3,
                        onTap: () => setState(
                          () {
                            sqareCheckbox3 = !sqareCheckbox3;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SqareCheckBox(
                        isRedText: !isCheckedSqareGroup,
                        text: 'Класса номера',
                        isChecked: sqareCheckbox4,
                        onTap: () => setState(
                          () {
                            sqareCheckbox4 = !sqareCheckbox4;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SubTitleText(text: 'Уведомления'),
                  const SizedBox(height: 10),
                  CircleCheckBox(
                    isRedText: !isCheckedCircleGroup,
                    text: 'Электронной почтой или по телефону',
                    isChecked: circleCheckbox1,
                    onTap: () => setState(
                      () {
                        circleCheckbox1 = !circleCheckbox1;
                        if (circleCheckbox2) {
                          circleCheckbox2 = false;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  CircleCheckBox(
                    isRedText: !isCheckedCircleGroup,
                    text: 'Через личный кабинет',
                    isChecked: circleCheckbox2,
                    onTap: () => setState(
                      () {
                        circleCheckbox2 = !circleCheckbox2;
                        if (circleCheckbox1) {
                          circleCheckbox1 = false;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SubTitleText(text: 'Телефоны для связи'),
                  TextInput(
                    hintText: 'Основной',
                    errorText: 'Введите номер телефона',
                    controller: mainPhone,
                  ),
                  const SizedBox(height: 10),
                  TextInput(
                    hintText: 'Дополнительный',
                    errorText: 'Введите номер телефона',
                    controller: additionalPhone,
                  ),
                  const SizedBox(height: 20),
                  TextInputWithText(
                    errorText: '',
                    controller: comment,
                    validator: const EmptyValidator(),
                    subtitle: 'Комментарий',
                  ),
                  const SizedBox(height: 20),
                  SqareCheckBox(
                    isRedText: !isCheckedAgreement,
                    text:
                        'Я подтверждаю свое согласие на получение (в соответствии с действующим Колективным договором ОАО "РЖД") путевки на санаторно-куротное оздоровление и отдых и самостоятельное оформление и получение санаторно-курортной карты при потребности получения лечения в объекте, указанном в путевке.',
                    isChecked: agreementCheckbox,
                    onTap: () => setState(
                      () {
                        agreementCheckbox = !agreementCheckbox;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<SankurObjectsBloc, SankurObjectsState>(
                    builder: (context, objState) {
                      return BlocConsumer<SankurFormBloc, SankurFormState>(
                        listener: (context, state) {
                          if (state is SankurSended) {
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
                              if (!sqareCheckbox1 &&
                                  !sqareCheckbox2 &&
                                  !sqareCheckbox3 &&
                                  !sqareCheckbox4) {
                                isCheckedSqareGroup = false;
                              } else {
                                isCheckedSqareGroup = true;
                              }
                              if (!circleCheckbox1 && !circleCheckbox2) {
                                isCheckedCircleGroup = false;
                              } else {
                                isCheckedCircleGroup = true;
                              }
                              if (agreementCheckbox == false) {
                                isCheckedAgreement = false;
                              } else {
                                isCheckedAgreement = true;
                              }
                              setState(() {});
                              if (formKey.currentState?.validate() == true &&
                                  isCheckedSqareGroup &&
                                  isCheckedCircleGroup &&
                                  isCheckedAgreement &&
                                  state is! SankurSendLoading) {
                                SankurForm sankurForm = SankurForm(
                                  period: int.parse(period.text),
                                  year: int.parse('2024'),
                                  days: int.parse(duration.text),
                                  filename: '',
                                  no_treatment: circleCheckbox1 ? true : false,
                                  mobile_phone: mainPhone.text,
                                  category: numberClass.text,
                                  sanprof: objState is SankurObjectsInitial
                                      ? objState.objects.indexWhere((element) =>
                                          element.name == restObject.text)
                                      : -1,
                                  comment: comment.text,
                                );
                                context
                                    .read<SankurFormBloc>()
                                    .add(SankurSend(sankurForm: sankurForm));
                              }
                            },
                            text: state is! SankurSendLoading
                                ? 'Отправить'
                                : 'Отправка...',
                            color: state is! SankurSendLoading
                                ? ColorsUI.activeRed
                                : ColorsUI.inactiveRedLight,
                            textColor: state is! SankurSendLoading
                                ? ColorsUI.mainWhite
                                : ColorsUI.activeRed,
                          );
                        },
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
