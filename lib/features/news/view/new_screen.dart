import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rzd/core/colors.dart';
import 'package:rzd/features/menu/app_bar.dart';
import 'package:rzd/features/news/model/new_info.dart';
import 'package:rzd/features/news/view/bloc/new_bloc.dart';
import 'package:rzd/features/news/view/widget/news_content.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key, required this.newInfo});

  final NewInfo newInfo;

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  late final ScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: controller,
        child: BlocBuilder<NewBloc, NewState>(
          builder: (context, state) {
            if (state is NewInitial) {
              final bufferList = state.news;
              bufferList.removeWhere(
                  (element) => element.contentId == widget.newInfo.contentId);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomNotificationsAppBar(
                    appbarText: 'Новости',
                    withTopPadding: false,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: ColorsUI.mainWhite,
                        borderRadius: BorderRadius.circular(24)),
                    child: NewsContent(
                      isHomePage: false,
                      newInfo: widget.newInfo,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: ColorsUI.mainWhite,
                        borderRadius: BorderRadius.circular(24)),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: bufferList.length,
                      separatorBuilder: (context, index) => Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 4,
                            decoration: const BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  Color.fromRGBO(226, 232, 240, 1),
                                  Color.fromRGBO(226, 232, 240, 0),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      itemBuilder: (context, index) => NewsContent(
                        onTap: () => controller.animateTo(0,
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeIn),
                        newInfo: bufferList[index],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
