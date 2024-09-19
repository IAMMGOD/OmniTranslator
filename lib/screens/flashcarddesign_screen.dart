import 'package:flutter/material.dart';
import 'package:omnitranslator/models/flashcard_model.dart';
import 'package:omnitranslator/providers/flashcard_provider.dart';
import 'package:provider/provider.dart';

class FlashcardDesignScreen extends StatefulWidget {
  final String packageName;

  FlashcardDesignScreen({required this.packageName});

  @override
  _FlashcardDesignScreenState createState() => _FlashcardDesignScreenState();
}

class _FlashcardDesignScreenState extends State<FlashcardDesignScreen> {
  final TextEditingController frontSideController = TextEditingController();
  final TextEditingController backSideController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Design Flashcard'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: frontSideController,
              decoration: InputDecoration(
                labelText: 'Word or Phrase',

              ),
            ),
            TextField(
              controller: backSideController,
              decoration: InputDecoration(
                labelText: 'Translation',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (frontSideController.text.isNotEmpty && backSideController.text.isNotEmpty) {
                  Flashcard newFlashcard = Flashcard(
                    frontSide: frontSideController.text,
                    backSide: backSideController.text,
                  );

                  context
                      .read<FlashcardProvider>()
                      .addFlashcardToPackage(newFlashcard, widget.packageName);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Flashcard added to ${widget.packageName}'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // Clear fields for adding more flashcards
                  frontSideController.clear();
                  backSideController.clear();

                  // Go back to previous screen
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Save Flashcard',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(150, 50), backgroundColor: Colors.blue[900], // Set the desired width and height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // No rounded corners
                ), // Change to your desired button color
              ),
            ),

          ],
        ),
      ),
    );
  }
}
