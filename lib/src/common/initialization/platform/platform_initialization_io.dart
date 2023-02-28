import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> platformInitialization() =>
    io.Platform.isAndroid || io.Platform.isIOS ? _mobileInitialization() : _desktopInitialization();

Future<void> _mobileInitialization() async {}

Future<void> _desktopInitialization() async {
  // Must add this line.
  await windowManager.ensureInitialized();
  const windowOptions = WindowOptions(
    minimumSize: Size(300, 400),
    size: Size(800, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    alwaysOnTop: true,
    fullScreen: false,
    title: 'Application Performance Monitoring',
  );
  await windowManager.waitUntilReadyToShow(
    windowOptions,
    () async {
      if (io.Platform.isMacOS) {
        await windowManager.setMovable(true);
      }
      await windowManager.setMaximizable(false);
      await windowManager.show();
      await windowManager.focus();
    },
  );
}
