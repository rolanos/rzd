import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rzd/features/auth/view/logic/auth_bloc.dart';
import 'package:rzd/features/home/data/model/card_data.dart';
import 'package:rzd/features/home/view/widget/benefits_card.dart';
import 'package:rzd/features/menu/app_bar.dart';

import 'widget/bank_data_widget.dart';
import 'widget/useful_materials.dart';
import 'widget/user_data_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  isTopPadding: false,
                  appbarText: (state is AuthSuccess &&
                          state.profile.name != null &&
                          state.profile.otch != null)
                      ? "${state.profile.name!} ${state.profile.otch!}"
                      : "",
                ),
                const SizedBox(
                  height: 8.0,
                ),
                if (state is AuthSuccess)
                  UserDataWidget(
                    title: 'Ваши анкетные данные',
                    subTitle:
                        'Данные для выплат подтверждены на ${state.profile.pmg} год',
                    data: [
                      DataTile(
                        title: 'ФИО',
                        text:
                            '${state.profile.fam ?? ''} ${state.profile.name ?? ''} ${state.profile.otch ?? ''}',
                      ),
                      DataTile(
                        title: 'Дата рождения',
                        text: state.profile.birthDate ?? '',
                      ),
                      DataTile(
                        title: 'Серия и номер паспорта',
                        text: state.profile.passport ?? '',
                      ),
                      DataTile(
                        title: 'СНИЛС',
                        text: state.profile.snils ?? '',
                      ),
                      DataTile(
                        title: 'Адрес',
                        text: state.profile.address ?? '',
                      ),
                      DataTile(
                        title: 'Электронная почта',
                        text: state.profile.email ?? '',
                      ),
                      DataTile(
                        title: 'Дата увольнения',
                        text: state.profile.retirementDate != null
                            ? DateFormat('dd.MM.yyyy')
                                .format(state.profile.retirementDate!)
                            : '',
                      ),
                      DataTile(
                        title: 'Стаж',
                        text: state.profile.experience ?? '',
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                if (state is AuthSuccess)
                  BankDataWidget(
                    title: 'Ваши банковские реквизиты',
                    data: [
                      DataTile(
                        title: 'БИК',
                        text: state.profile.bankAccount?.bic ?? '',
                      ),
                      DataTile(
                        title: ' Наименование банка',
                        text: state.profile.bankAccount?.bankName ?? '',
                      ),
                      DataTile(
                        title: 'Номер счета',
                        text: state.profile.bankAccount?.account ?? '',
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                if (state is AuthSuccess)
                  UsefulMaterials(
                    mainTitle: 'Полезные материалы',
                    cardData: [
                      CardData(
                        onTap: () => context.goNamed('faq'),
                        title: 'Ответы на частые вопросы ',
                        assetPath: 'asset/images/human_5.png',
                      ),
                      CardData(
                        onTap: () => context.goNamed('support'),
                        title: 'Форма для обратной связи',
                        assetPath: 'asset/images/notes.png',
                      ),
                      CardData(
                        onTap: () => context.pushNamed('docs'),
                        title: 'Нормативные документы',
                        assetPath: 'asset/images/books.png',
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
