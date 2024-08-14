import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: StreamBuilder(
            stream: FlutterOverlayWindow.overlayListener,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                );
              }
              return const Text(
                "Waiting for translation...",
                style: TextStyle(color: Colors.white, fontSize: 18),
              );
            },
          ),
        ),
      ),
    );
  }
}
