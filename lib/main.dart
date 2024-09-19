import 'package:flutter/material.dart';
import 'package:omnitranslator/providers/flashcard_provider.dart';
import 'package:omnitranslator/screens/flashcard_screen.dart';
import 'package:omnitranslator/screens/flashcarddesign_screen.dart';
import 'package:omnitranslator/themes.dart'; // Adjust path according to the folder structure
import 'bottom_navbar.dart'; // Ensure this contains your BottomNavBar widget
import 'package:provider/provider.dart';
import 'providers/notes_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
        ChangeNotifierProvider(create: (_) => FlashcardProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'Omnitranslator',
          theme: themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: BottomNavBar(), // Ensure BottomNavBar exists and is set up correctly
          // Define your routes here
          onGenerateRoute: (settings) {
            if (settings.name == '/design') {
              // Extract the arguments passed
              final packageName = settings.arguments as String;
              return MaterialPageRoute(
                builder: (context) {
                  return FlashcardDesignScreen(packageName: packageName);
                },
              );
            }
            // Add more routes as needed
            return null;
          },
        );
      },
    );
  }
}


