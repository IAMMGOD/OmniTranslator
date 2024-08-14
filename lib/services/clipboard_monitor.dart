// import 'package:clipboard_watcher/clipboard_watcher.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class ClipboardMonitor extends StatefulWidget {
//   const ClipboardMonitor({super.key});
//
//   @override
//   State<ClipboardMonitor> createState() => _ClipboardMonitorState();
// }
//
// class _ClipboardMonitorState extends State<ClipboardMonitor> {
//   @override
//   void initState() {
//     clipboardWatcher.addListener(this);
//     // start watch
//     clipboardWatcher.start();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     clipboardWatcher.removeListener(this);
//     // stop watch
//     clipboardWatcher.stop();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // ...
//   }
//
//   @override
//   void onClipboardChanged() async {
//     ClipboardData? newClipboardData = await Clipboard.getData(Clipboard.kTextPlain);
//     print(newClipboardData?.text ?? "");
//   }
//
// }
