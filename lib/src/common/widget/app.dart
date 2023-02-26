import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../feature/home/widget/home_screen.dart';
import '../localization/localization.dart';

/// {@template app}
/// App widget
/// {@endtemplate}
class App extends StatefulWidget {
  /// {@macro app}
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Application Performance Monitoring',
        restorationScopeId: 'material_app',
        debugShowCheckedModeBanner: false,
        theme: ui.window.platformBrightness == Brightness.dark ? ThemeData.dark() : ThemeData.light(),
        themeMode: ThemeMode.system,
        localizationsDelegates: const <LocalizationsDelegate<Object?>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          Localization.delegate,
        ],
        supportedLocales: Localization.supportedLocales,
        home: const HomeScreen(),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child ?? const SizedBox.shrink(),
        ),
      );
}
