import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'src/common/initialization/initialization.dart';
import 'src/common/util/error_util.dart';
import 'src/common/util/logging.dart';
import 'src/common/widget/app.dart';
import 'src/common/widget/app_error.dart';
import 'src/common/widget/radial_progress_indicator.dart';

void main() => runZonedGuarded<void>(
      () async {
        // Splash screen
        runApp(const _InitializationSpinner());
        try {
          // Logo and splash screen
          await $initializeApp();
        } on Object catch (error, stackTrace) {
          ErrorUtil.logError(error, stackTrace).ignore();
          runApp(const AppError());
          return;
        }
        runApp(const App());
      },
      severe,
      zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, message) {
          fine(message);
        },
      ),
    );

class _InitializationSpinner extends StatelessWidget {
  const _InitializationSpinner();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ui.window.platformBrightness == Brightness.dark
          ? ThemeData.dark().primaryColor
          : ThemeData.light().primaryColor,
      child: const Center(
        child: RadialProgressIndicator(size: 256),
      ),
    );
  }
}
