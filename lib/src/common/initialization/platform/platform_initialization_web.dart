import 'dart:html' as html;

//import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> platformInitialization() async {
  //setUrlStrategy(const HashUrlStrategy());
  Future.delayed(
    const Duration(seconds: 1),
    () {
      html.document.getElementById('splash')?.remove();
      html.document.getElementById('splash-branding')?.remove();
      html.document.body?.style.background = 'transparent';
      html.document
          .getElementsByClassName('splash-loading')
          .toList(growable: false)
          .forEach((element) => element.remove());
    },
  );
}
