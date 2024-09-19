//WHERE I WANT TO BE
import 'package:flutter/material.dart';
import 'package:omnitranslator/models/flashcard_model.dart';
import 'package:omnitranslator/providers/flashcard_provider.dart';
import 'package:omnitranslator/providers/flashcardpackage_provider.dart';
import 'package:omnitranslator/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Notepad'),
        backgroundColor: Colors.blue[900],
      ),
      backgroundColor: Colors.blue[900],
      body: Consumer2<NotesProvider, FlashcardProvider>(
        builder: (context, notesProvider, flashcardProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: notesProvider.notes.isEmpty
                      ? Center(
                    child: Text(
                      'No notes yet!',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                      : ListView.builder(
                    itemCount: notesProvider.notes.length,
                    itemBuilder: (context, index) {
                      String note = notesProvider.notes[index];
                      return ListTile(
                        title: Text(
                          note,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (String value) {
                            Flashcard newFlashcard = Flashcard(
                              frontSide: note,
                              backSide: 'Translation here', // Replace with actual logic
                            );
                            flashcardProvider.addFlashcardToPackage(newFlashcard, value);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Flashcard added to $value!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          itemBuilder: (BuildContext context) {
                            // Create a list of existing packages
                            return flashcardProvider.flashcardPackages.map((package) {
                              return PopupMenuItem<String>(
                                value: package.name,
                                child: Text('Add to ${package.name}'),
                              );
                            }).toList();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _showAddNoteDialog(context),
            child: Icon(Icons.book),
            backgroundColor: Colors.white,
            heroTag: null,
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => _showCreatePackageDialog(context),
            child: Icon(Icons.folder),
            backgroundColor: Colors.white,
            heroTag: null,
          ),
        ],
      ),
    );
  }

  // Show a dialog to create a new note
  void _showAddNoteDialog(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Note'),
          content: TextField(
            controller: _noteController,
            decoration: InputDecoration(hintText: 'Enter your note'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String note = _noteController.text.trim();
                if (note.isNotEmpty) {
                  context.read<NotesProvider>().addNote(note);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show a dialog to create a new flashcard package
  void _showCreatePackageDialog(BuildContext context) {
    final TextEditingController _packageNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create New Flashcard Package'),
          content: TextField(
            controller: _packageNameController,
            decoration: InputDecoration(hintText: 'Enter package name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String packageName = _packageNameController.text.trim();
                if (packageName.isNotEmpty) {
                  FlashcardPackage newPackage = FlashcardPackage(name: packageName, flashcards: []);
                  context.read<FlashcardProvider>().addFlashcardPackage(newPackage);

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Flashcard package $packageName created!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: Text('Create'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}



