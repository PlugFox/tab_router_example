import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:l/l.dart';

import 'src/common/initialization/initialization.dart';
import 'src/common/util/error_util.dart';
import 'src/common/widget/app.dart';
import 'src/common/widget/app_error.dart';

void main() => runZonedGuarded<void>(
      () => l.capture<void>(
        () async {
          try {
            await $initializeApp();
          } on Object catch (error, stackTrace) {
            ErrorUtil.logError(error, stackTrace).ignore();
            runApp(const AppError());
            return;
          }
          runApp(const App());
        },
        const LogOptions(
          handlePrint: true,
          outputInRelease: true,
          printColors: true,
        ),
      ),
      l.e,
    );
