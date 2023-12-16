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

  GlobalKey benefits = GlobalKey();
  GlobalKey references = GlobalKey();
  GlobalKey history = GlobalKey();

  CustomTabController({
    required this.scrollController,
  }) {
    scrollController.addListener(() {
      if (scrollController.offset <
          scrollController.position.maxScrollExtent / 3) {
        category = Category.benefits;
        notifyListeners();
      }
      if (scrollController.offset >
              scrollController.position.maxScrollExtent / 3 &&
          scrollController.offset <
              scrollController.position.maxScrollExtent * 2 / 3) {
        category = Category.references;
        notifyListeners();
      }
      if (scrollController.offset >
          scrollController.position.maxScrollExtent * 2 / 3) {
        category = Category.history;
        notifyListeners();
      }
    });
  }

  dispose() {
    scrollController.dispose();
  }

  goToBenifits() {
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      RenderBox box = benefits.currentContext?.findRenderObject() as RenderBox;

      scrollController.jumpTo(0);
      category = Category.benefits;
      notifyListeners();
    }
  }

  goToReferences() {
    if (scrollController.hasClients) {
      double offset = scrollController.offset;

      Scrollable.ensureVisible(references.currentContext!);

      category = Category.references;
      notifyListeners();
    }
  }

  goToHistory() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      category = Category.history;
      notifyListeners();
    }
  }
}
