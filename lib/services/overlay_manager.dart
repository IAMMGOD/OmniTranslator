import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter/material.dart';

class OverlayManager {
  static Future<void> startOverlay() async {
    final bool isGranted = await FlutterOverlayWindow.isPermissionGranted();

    if (!isGranted) {
      await FlutterOverlayWindow.requestPermission();
    }

    await FlutterOverlayWindow.showOverlay(
      flag: OverlayFlag.focusPointer,
      overlayTitle: "Omni Overlay",
      overlayContent: "Translating...",
      height: WindowSize.fullCover,
      width: WindowSize.matchParent,
      enableDrag: true,
      alignment: OverlayAlignment.topCenter,
    );
  }

  static Future<void> closeOverlay() async {
    await FlutterOverlayWindow.closeOverlay();
  }

  static Future<void> updateOverlay(String text) async {
    await FlutterOverlayWindow.shareData(text);
  }
}
