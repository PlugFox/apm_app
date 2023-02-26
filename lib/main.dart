import 'dart:async';

import 'package:flutter/material.dart';

import 'src/common/initialization/initialization.dart';
import 'src/common/util/error_util.dart';
import 'src/common/util/logging.dart';
import 'src/common/widget/app.dart';
import 'src/common/widget/app_error.dart';

void main() => runZonedGuarded<void>(
      () async {
        runApp(const Material(child: Center(child: CircularProgressIndicator())));
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
