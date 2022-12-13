import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../feature/authentication/widget/authentication_scope.dart';
import '../../feature/settings/widget/theme_scope.dart';
import '../localization/localization.dart';
import 'error_screen.dart';

/// {@template material_scope}
/// MaterialScope widget
/// {@endtemplate}
class MaterialScope extends StatefulWidget {
  /// {@macro material_scope}
  const MaterialScope({
    required this.routerConfig,
    super.key,
  });

  final RouterConfig<Object> routerConfig;

  @override
  State<MaterialScope> createState() => _MaterialScopeState();
}

/// State for widget MaterialScope
class _MaterialScopeState extends State<MaterialScope> {
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Router example',
        restorationScopeId: 'material_scope',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeScope.modeOf(context),
        theme: ThemeScope.dataOf(context),
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
            child: AuthenticationScope(
              child: child ?? ErrorScreen(exception: Exception('No child')),
            ),
          ),
        ),
      );
}
