import 'dart:developer';
import 'dart:math' as mt;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Category {
  benefits,
  references,
  history,
}

class CustomTabController extends ChangeNotifier {
  Category category = Category.benefits;

  final ScrollController scrollController;
  final ScrollController tabScrollController;

  GlobalKey benefits = GlobalKey();
  GlobalKey references = GlobalKey();
  GlobalKey history = GlobalKey();

  GlobalKey benefitsTab = GlobalKey();
  GlobalKey referencesTab = GlobalKey();
  GlobalKey historyTab = GlobalKey();

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
          category != Category.history) {
        category = Category.history;
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

  goToHistory() async {
    if (scrollController.hasClients) {
      double offset = scrollController.position.pixels;
      RenderBox? box = history.currentContext?.findRenderObject() as RenderBox?;

      Scrollable.ensureVisible(history.currentContext!);
      Scrollable.ensureVisible(historyTab.currentContext!);
      category = Category.history;
      notifyListeners();
    }
  }
}
