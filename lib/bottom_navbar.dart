import 'package:flutter/material.dart';
import 'package:omnitranslator/screens/flashcard_screen.dart';
import 'package:omnitranslator/screens/settings_screen.dart';
import 'package:omnitranslator/screens/translator_screen.dart';
import 'package:omnitranslator/screens/home_screen.dart';
import 'package:omnitranslator/providers/flashcard_provider.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  // Use IndexedStack to retain state between tabs
  final List<Widget> _children = [
    HomeScreen(),
    LanguageTranslation(),
    FlashcardsScreen(),
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
      body: IndexedStack(
        index: _currentIndex, // Show the currently selected screen
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue[900], // Selected item color
        unselectedItemColor: Colors.grey,    // Unselected item color
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
        items: const [
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
