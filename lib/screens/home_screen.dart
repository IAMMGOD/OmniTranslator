import 'package:flutter/material.dart';
import '../services/overlay_manager.dart';
import '../services/clipboard_monitor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // OverlayManager.startOverlay();
    // ClipboardMonitor.startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translator App'),
      ),
      body: Center(
        child: Text('hi'),
      ),
    );
  }
}
