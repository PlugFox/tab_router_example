import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tab_router/tab_router.dart';

import '../../feature/authentication/widget/authentication_scope.dart';
import '../localization/localization.dart';
import '../router/app_router.dart';
import 'error_screen.dart';

/// {@template material_scope}
/// MaterialScope widget
/// {@endtemplate}
class MaterialScope extends StatefulWidget {
  /// {@macro material_scope}
  const MaterialScope({
    required this.controller,
    required this.routerConfig,
    super.key,
  });

  final RouterController controller;
  final RouterConfig<Object> routerConfig;

  @override
  State<MaterialScope> createState() => _MaterialScopeState();
}

/// State for widget MaterialScope
class _MaterialScopeState extends State<MaterialScope> {
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'tab_router_example',
        restorationScopeId: 'app',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ui.window.platformBrightness == ui.Brightness.light ? ThemeData.light() : ThemeData.dark(),
        localizationsDelegates: const <LocalizationsDelegate<Object?>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          Localization.delegate,
        ],
        supportedLocales: Localization.supportedLocales,
        routerConfig: widget.routerConfig,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: Banner(
            message: 'PREVIEW',
            location: BannerLocation.topEnd,
            child: AppRouter(
              controller: widget.controller,
              child: AuthenticationScope(
                child: child ?? ErrorScreen(exception: Exception('No child')),
              ),
            ),
          ),
        ),
      );
}
