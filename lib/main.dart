import 'package:flutter/material.dart';
import 'package:omnitranslator/themes.dart'; // Adjust path according to the folder structure
import 'bottom_navbar.dart'; // Ensure this contains your BottomNavBar widget
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
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
          home: BottomNavBar(), // Make sure BottomNavBar exists and is set up correctly
        );
      },
    );
  }
}