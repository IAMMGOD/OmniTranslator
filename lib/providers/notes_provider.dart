import 'package:flutter/material.dart';

class NotesProvider with ChangeNotifier {
  List<String> _notes = [];

  List<String> get notes => _notes;

  void addNote(String note) {
    _notes.add(note);
    notifyListeners(); // Notify listeners to update UI
  }
}
