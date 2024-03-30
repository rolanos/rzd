import 'package:flutter/material.dart';
import 'package:rzd/core/colors.dart';

class WarningContainer extends StatelessWidget {
  const WarningContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorsUI.mainWhite,
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Обратите внимание',
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Text(
            '''Рекомендуем заранее подавать заявки на отдых (в текущем году на следующий).
Вы можете изменить даты заезда, количество дней отдыха, желаемый объект, категорию номера, а также отказаться от путевки, если она еще не одобрена, обратившись на Горячую линию (ИКЦ). Если путевка уже одобрена, изменение ее параметров возможно при наличии свободных мест в предполагаемом объекте размещения. Путевка предоставляется на санаторно-курортное оздоровление.
При потребности получения лечения Вам необходимо самостоятельно оформить санаторно-курортную карту (не рекомендуем оформлять карту до получения подтверждения об одобрении путевки).
Для ряда объектов нужна справка об эпидемиологическом окружении по месту жительства и санаторно-курортная карта по форме 072/у.''',
            style: textTheme.bodySmall?.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
