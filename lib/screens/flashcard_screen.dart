import 'package:flutter/material.dart';
import 'package:omnitranslator/providers/flashcard_provider.dart';
import 'package:omnitranslator/providers/flashcardpackage_provider.dart';
import 'package:provider/provider.dart';

class FlashcardsScreen extends StatefulWidget {
  @override
  _FlashcardsScreenState createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  int _currentIndex = 0;
  bool _isFrontSide = true;
  String? _selectedPackage;

  void _navigateToDesignScreen() {
    if (_selectedPackage != null) {
      Navigator.pushNamed(
        context,
        '/design',
        arguments: _selectedPackage!,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a package first')),
      );
    }
  }

  void _showPreviousCard() {
    setState(() {
      if (_selectedPackage != null) {
        final package = context.read<FlashcardProvider>().flashcardPackages
            .firstWhere((pkg) => pkg.name == _selectedPackage!);

        if (package.flashcards.isNotEmpty) {
          _currentIndex = (_currentIndex - 1) % package.flashcards.length;
          if (_currentIndex < 0) {
            _currentIndex += package.flashcards.length;
          }
        }
      }
    });
  }

  void _showNextCard() {
    setState(() {
      if (_selectedPackage != null) {
        final package = context.read<FlashcardProvider>().flashcardPackages
            .firstWhere((pkg) => pkg.name == _selectedPackage!);

        if (package.flashcards.isNotEmpty) {
          _currentIndex = (_currentIndex + 1) % package.flashcards.length;
        }
      }
    });
  }

  void _selectPackage(String packageName) {
    setState(() {
      _selectedPackage = packageName;
      _currentIndex = 0;
      _isFrontSide = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcardPackages = context.watch<FlashcardProvider>().flashcardPackages;

    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text('Omni-Flashcards',
        style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _createFlashcardPackage(context),
          ),
          if (_selectedPackage != null)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: _navigateToDesignScreen,
            ),
        ],
      ),
      body: _selectedPackage == null
          ? ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: flashcardPackages.length,
        itemBuilder: (context, index) {
          final package = flashcardPackages[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
              child: InkWell(
                onTap: () => _selectPackage(package.name),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[300]!, Colors.blue[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.folder_open, size: 40, color: Colors.white),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              package.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '${package.flashcards.length} flashcards',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
          : Column(
        children: [
          Expanded(
            child: Center(
              child: Builder(
                builder: (context) {
                  final package = flashcardPackages.firstWhere(
                        (pkg) => pkg.name == _selectedPackage!,
                    orElse: () => FlashcardPackage(name: '', flashcards: []),
                  );

                  if (package.flashcards.isEmpty) {
                    return Text(
                      'No flashcards available',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isFrontSide = !_isFrontSide;
                          });
                        },
                        child: AnimatedCrossFade(
                          firstChild: _buildCard(package.flashcards[_currentIndex].frontSide),
                          secondChild: _buildCard(package.flashcards[_currentIndex].backSide),
                          crossFadeState: _isFrontSide
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: Duration(milliseconds: 500),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.blue[400]),
                            onPressed: _showPreviousCard,
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward, color: Colors.blue[400]),
                            onPressed: _showNextCard,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _selectedPackage = null;
              });
            },
            icon: Icon(Icons.arrow_back, color: Colors.black),
            label: Text('Back to Packages', style: TextStyle(color: Colors.black),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              elevation: 5,
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildCard(String text) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[300]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
    );
  }

  void _createFlashcardPackage(BuildContext context) {
    final TextEditingController packageNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Flashcard Package'),
          content: TextField(
            controller: packageNameController,
            decoration: InputDecoration(labelText: 'Package Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (packageNameController.text.isNotEmpty) {
                  final newPackage = FlashcardPackage(
                    name: packageNameController.text,
                    flashcards: [],
                  );
                  context.read<FlashcardProvider>().addFlashcardPackage(newPackage);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Package name cannot be empty')),
                  );
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
