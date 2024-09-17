import 'package:flutter/material.dart';

class Flashcard {
  String frontSide;
  String backSide;

  Flashcard({required this.frontSide, required this.backSide});
}

class FlashcardsScreen extends StatefulWidget {
  final List<Flashcard> flashcards;

  FlashcardsScreen({required this.flashcards});

  @override
  _FlashcardsScreenState createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  int _currentIndex = 0;
  bool _isFrontSide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isFrontSide = !_isFrontSide;
            });
          },
          child: AnimatedCrossFade(
            firstChild: _frontSide(),
            secondChild: _backSide(),
            crossFadeState: _isFrontSide
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 500),
          ),
        ),
      ),
    );
  }

  Widget _frontSide() {
    return Card(
      child: Container(
        width: 200,
        height: 200,
        child: Center(
          child: Text(widget.flashcards[_currentIndex].frontSide),
        ),
      ),
    );
  }

  Widget _backSide() {
    return Card(
      child: Container(
        width: 200,
        height: 200,
        child: Center(
          child: Text(widget.flashcards[_currentIndex].backSide),
        ),
      ),
    );
  }

  void _nextFlashcard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.flashcards.length;
      _isFrontSide = true;
    });
  }
}