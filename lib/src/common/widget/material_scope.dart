import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../feature/authentication/widget/authentication_scope.dart';
import '../localization/localization.dart';
import '../router/router.dart';
import 'error_screen.dart';

/// {@template material_scope}
/// MaterialScope widget
/// {@endtemplate}
class MaterialScope extends StatefulWidget {
  /// {@macro material_scope}
  const MaterialScope({super.key});

  @override
  State<MaterialScope> createState() => _MaterialScopeState();
}

/// State for widget MaterialScope
class _MaterialScopeState extends State<MaterialScope> {
  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'go_router_example',
        restorationScopeId: 'app',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ui.window.platformBrightness == ui.Brightness.light
            ? ThemeData.light()
            : ThemeData.dark(),
        localizationsDelegates: const <LocalizationsDelegate<Object?>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          Localization.delegate,
        ],
        supportedLocales: Localization.supportedLocales,
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: Banner(
            message: 'PREVIEW',
            location: BannerLocation.topEnd,
            child: AuthenticationScope(
              child: child ?? ErrorScreen(exception: Exception('No child')),
            ),
          ),
        ),
      );
}
