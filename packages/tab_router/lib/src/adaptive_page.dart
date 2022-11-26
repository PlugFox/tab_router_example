import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_info/platform_info.dart';

import 'named_page.dart';

class AdaptivePage extends NamedPage {
  AdaptivePage({
    required super.name,
    required WidgetBuilder builder,
    super.arguments,
    super.restorationId,
  }) : _builder = builder;

  final WidgetBuilder _builder;

  @override
  Route<void> createRoute(BuildContext context) => Platform.I.isIOS
      ? CupertinoPageRoute(
          settings: this,
          builder: _builder,
        )
      : MaterialPageRoute(
          settings: this,
          builder: _builder,
        );
}
