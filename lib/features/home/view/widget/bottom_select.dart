import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/colors.dart';

Future<String?> showBottomSelect(BuildContext context, List<String> select,
    [String? titleText]) async {
  int selectedIndex = -1;
  await showModalBottomSheet<String>(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: ColorsUI.mainWhite,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    titleText ?? "Выберите тему",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      color: ColorsUI.otpBorder,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: SvgPicture.asset('asset/icons/cross.svg'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              StatefulBuilder(
                builder: (context, setState) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 24,
                                  width: 24,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: selectedIndex == index
                                          ? ColorsUI.activeRed
                                          : ColorsUI.borderColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      height: 14,
                                      width: 14,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: selectedIndex == index
                                            ? ColorsUI.activeRed
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    select[index],
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: ColorsUI.otpBorder,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: select.length);
                },
              )
            ],
          ),
        ),
      );
    },
  );
  if (selectedIndex >= 0 && selectedIndex <= select.length - 1) {
    return select[selectedIndex];
  }
  return '';
}
