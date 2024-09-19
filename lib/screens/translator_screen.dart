import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:omnitranslator/translator_speciics/languages.dart';
import 'package:omnitranslator/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class LanguageTranslation extends StatefulWidget {
  const LanguageTranslation({super.key});

  @override
  State<LanguageTranslation> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslation> {
  var originalLanguage = "Select a language";
  var destinationLanguage = "Select a language";
  var output = "";
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    try {
      GoogleTranslator translator = GoogleTranslator();
      var translation = await translator.translate(input, from: src, to: dest);
      setState(() {
        output = translation.text;
      });
    } catch (e) {
      setState(() {
        output = "Failed to translate: $e";
      });
      print("Translation error: $e"); // Log the error for debugging
      print("Source language code: $src");
      print("Destination language code: $dest");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: const Text(
          'Omni Translator',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Language selection row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Source Language Dropdown
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: originalLanguage,
                    onChanged: (String? value) {
                      setState(() {
                        originalLanguage = value!;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: "Select a language",
                        child: Text("Select a language"),
                      ),
                      ...languages.map((String language) {
                        return DropdownMenuItem<String>(
                          value: language,
                          child: Text(language),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.swap_horiz, color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      var temp = originalLanguage;
                      originalLanguage = destinationLanguage;
                      destinationLanguage = temp;
                    });
                  },
                ),
                // Destination Language Dropdown
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: destinationLanguage,
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: "Select a language",
                        child: Text("Select a language"),
                      ),
                      ...languages.map((String language) {
                        return DropdownMenuItem<String>(
                          value: language,
                          child: Text(language),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Input Text Area
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: TextFormField(
                controller: languageController,
                maxLines: 5,
                cursorColor: Colors.black,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enter text to translate...',
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Translate Button
            ElevatedButton(
              onPressed: () {
                if (originalLanguage != "Select a language" &&
                    destinationLanguage != "Select a language") {
                  translate(
                    getLanguageCode(originalLanguage),
                    getLanguageCode(destinationLanguage),
                    languageController.text.toString(),
                  );
                } else {
                  setState(() {
                    output = "Please select both source and destination languages";
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Translate",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),

            const SizedBox(height: 20),

            // Output Translation Area
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        output.isEmpty ? 'Translation will appear here' : output,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const Icon(Icons.star_border),
                        onPressed: () {
                          if (output.isNotEmpty) {
                            Provider.of<NotesProvider>(context, listen: false)
                                .addNote(output);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Translation added to notes!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Nothing to add! Translate something first.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
