import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../common/widget/radial_progress_indicator.dart';

class InitializationSpinner extends StatelessWidget {
  const InitializationSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ui.window.platformBrightness == Brightness.dark
          ? ThemeData.dark().primaryColor
          : ThemeData.light().primaryColor,
      child: const Center(
        child: RadialProgressIndicator(size: 128),
      ),
    );
  }
}
