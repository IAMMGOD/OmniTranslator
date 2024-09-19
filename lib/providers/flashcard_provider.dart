// 3RD MOST RECENT EDIT(EVERYTHING WORKING GOOD , EXCEPT THE ADD PACKAGE CLICK)
import 'package:flutter/cupertino.dart';
import 'package:omnitranslator/models/flashcard_model.dart';
import 'package:omnitranslator/providers/flashcardpackage_provider.dart';

class FlashcardProvider extends ChangeNotifier {
  List<FlashcardPackage> _flashcardPackages = [];

  List<FlashcardPackage> get flashcardPackages => _flashcardPackages;

  // Add a flashcard package
  void addFlashcardPackage(FlashcardPackage package) {
    _flashcardPackages.add(package);
    notifyListeners();
  }

  // Add a flashcard to a specific package
  void addFlashcardToPackage(Flashcard flashcard, String packageName) {
    final package = _flashcardPackages.firstWhere((pkg) => pkg.name == packageName);
    package.flashcards.add(flashcard);
    notifyListeners();
  }
}



