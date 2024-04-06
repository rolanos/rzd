import 'dart:developer';
import 'dart:math' as mt;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Category {
  benefits,
  references,
  faq,
  news,
}

class CustomTabController extends ChangeNotifier {
  Category category = Category.benefits;

  final ScrollController scrollController;
  final ScrollController tabScrollController;

  GlobalKey benefits = GlobalKey();
  GlobalKey references = GlobalKey();
  GlobalKey news = GlobalKey();
  GlobalKey faq = GlobalKey();

  GlobalKey benefitsTab = GlobalKey();
  GlobalKey referencesTab = GlobalKey();
  GlobalKey newsTab = GlobalKey();
  GlobalKey faqTab = GlobalKey();

  CustomTabController({
    required this.tabScrollController,
    required this.scrollController,
  }) {
    log("Scroll id in Controller - " + scrollController.hashCode.toString());
    scrollController.addListener(() {
      if (scrollController.offset <
              scrollController.position.maxScrollExtent / 3 &&
          category != Category.benefits) {
        tabScrollController.animateTo(
          0,
          duration: Duration(milliseconds: 256),
          curve: Curves.easeIn,
        );
        category = Category.benefits;
        notifyListeners();
      }
      if (scrollController.offset >
              scrollController.position.maxScrollExtent / 3 &&
          scrollController.offset <
              scrollController.position.maxScrollExtent * 2 / 3 &&
          category != Category.references) {
        category = Category.references;
        notifyListeners();
      }
      if (scrollController.offset >
              scrollController.position.maxScrollExtent * 2 / 3 &&
          category != Category.news) {
        category = Category.news;
        tabScrollController.animateTo(
          tabScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 256),
          curve: Curves.easeIn,
        );
        notifyListeners();
      }
    });
  }

  dispose() {
    scrollController.dispose();
  }

  goToBenifits() async {
    if (scrollController.hasClients) {
      double offset = scrollController.position.pixels;
      RenderBox? box =
          benefits.currentContext?.findRenderObject() as RenderBox?;
      Scrollable.ensureVisible(benefits.currentContext!);
      await tabScrollController.animateTo(0,
          duration: Duration(milliseconds: 256), curve: Curves.easeIn);
      category = Category.benefits;
      notifyListeners();
    }
  }

  goToReferences() async {
    if (scrollController.hasClients) {
      double offset = scrollController.position.pixels;
      RenderBox? box =
          benefits.currentContext?.findRenderObject() as RenderBox?;

      Scrollable.ensureVisible(references.currentContext!);
      category = Category.references;
      notifyListeners();
    }
  }

  goToFaqs() async {
    if (scrollController.hasClients) {
      double offset = scrollController.position.pixels;
      RenderBox? box =
          benefits.currentContext?.findRenderObject() as RenderBox?;

      Scrollable.ensureVisible(faq.currentContext!);
      category = Category.faq;
      notifyListeners();
    }
  }

  goToNews() async {
    if (scrollController.hasClients) {
      double offset = scrollController.position.pixels;
      RenderBox? box = news.currentContext?.findRenderObject() as RenderBox?;

      Scrollable.ensureVisible(news.currentContext!);
      Scrollable.ensureVisible(news.currentContext!);
      category = Category.news;
      notifyListeners();
    }
  }
}
