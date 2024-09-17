import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class NoteProvider with ChangeNotifier {
  List<String> notes = [];

  void addNote(String note) {
    notes.add(note);
    notifyListeners();
  }

  void removeNote(int index) {
    notes.removeAt(index);
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteProvider>(create: (_) => NoteProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  final String favouriteText;

  HomeScreen({required this.favouriteText});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List to store notes
  List<String> notes = [];

  @override
  void initState() {
    super.initState();
    // Add the favourite text to the list only if it's not empty
    if (widget.favouriteText.isNotEmpty) {
      notes.add(widget.favouriteText);
    }
  }


  // Controller to handle text input
  TextEditingController noteController = TextEditingController();

  // Control whether the TextField is visible or not
  bool isAddingNote = false;

  // Word limit
  final int wordLimit = 1000;

  // Function to add a note
  void addNote() {
    String note = noteController.text.trim();
    int wordCount = _getWordCount(note);

    if (wordCount > wordLimit) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot add note. Exceeded the 1000-word limit!'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      setState(() {
        notes.add(note); // Add the new note to the list
        noteController.clear(); // Clear the input field after adding
        isAddingNote = false; // Hide the TextField after adding the note
      });
    }
  }

  // Function to count words
  int _getWordCount(String text) {
    if (text.isEmpty) {
      return 0;
    }
    return text.split(RegExp(r'\s+')).length; // Split by whitespace to count words
  }

  // Function to delete a note
  void deleteNoteAtIndex(int index) {
    setState(() {
      notes.removeAt(index); // Remove the note from the list
    });
  }

  // Function to toggle the visibility of the TextField
  void toggleAddNote() {
    setState(() {
      isAddingNote = !isAddingNote; // Toggle the visibility
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Notepad'),
        backgroundColor: Colors.blue[900],
      ),
      backgroundColor: Colors.blue[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Conditionally show the TextField only when `isAddingNote` is true
            if (isAddingNote)
              Column(
                children: [
                  TextField(
                    controller: noteController,
                    style: TextStyle(color: Colors.white),
                    maxLines: null, // Allow multiple lines
                    decoration: InputDecoration(
                      labelText: 'Enter a note',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Button to save the note
                  ElevatedButton(
                    onPressed: addNote, // Calls the function to add a note
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Text('Save Note', style: TextStyle(color: Colors.blue[900])),
                  ),
                ],
              ),

            SizedBox(height: 20),

            // Expanded ListView to show notes
            Expanded(
              child: notes.isEmpty
                  ? Center(
                child: Text(
                  'No notes yet!',
                  style: TextStyle(color: Colors.white),
                ),
              )
                  : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      notes[index],
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteNoteAtIndex(index), // Delete the note
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // FloatingActionButton to show the TextField for adding a new note
      floatingActionButton: FloatingActionButton(
        onPressed: toggleAddNote, // Toggles the TextField visibility
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue[900],
      ),
    );
  }
}
