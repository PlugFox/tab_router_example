import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../../feature/authentication/widget/log_out_button.dart';
import '../../feature/profile/widget/profile_icon_button.dart';

class CommonActions extends ListBase<Widget> {
  CommonActions()
      : _actions = <Widget>[
          const ProfileIconButton(),
          const LogOutButton(),
        ];

  final List<Widget> _actions;

  @override
  int get length => _actions.length;

  @override
  set length(int newLength) => _actions.length = newLength;

  @override
  Widget operator [](int index) => _actions[index];

  @override
  void operator []=(int index, Widget value) => _actions[index] = value;
}
