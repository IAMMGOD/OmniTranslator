import 'package:flutter/material.dart';
import 'package:omnitranslator/screens/flashcard_screen.dart';
import 'package:omnitranslator/screens/settings_screen.dart';
import 'package:omnitranslator/screens/translator_screen.dart';
import 'package:omnitranslator/screens/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(favouriteText: '',),
    LanguageTranslation(),
    FlashcardsScreen(flashcards: [],),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
      onTap: _onItemTapped,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.blue[900], // changed selected item text color to blue[900]
      unselectedItemColor: Colors.blue[900],
      items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: 'Translator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on),
            label: 'Flashcards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}