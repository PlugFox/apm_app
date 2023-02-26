import 'dart:async';

import 'package:flutter/material.dart';

import 'src/common/initialization/initialization.dart';
import 'src/common/util/error_util.dart';
import 'src/common/util/logging.dart';
import 'src/common/widget/app.dart';
import 'src/common/widget/app_error.dart';
import 'src/feature/server/data/server.dart';

void main() => runZonedGuarded<void>(
      () async {
        try {
          // Logo and splash screen
          await $initializeApp();
        } on Object catch (error, stackTrace) {
          ErrorUtil.logError(error, stackTrace).ignore();
          runApp(const AppError());
          return;
        }
        Server().start();
        runApp(const App());
      },
      severe,
      zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, message) {
          fine(message);
        },
      ),
    );
