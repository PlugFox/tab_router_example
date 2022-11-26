import 'package:flutter/widgets.dart';

@immutable
class Tab with Comparable<Tab> {
  const Tab(this.index, this.name);

  final int index;

  final String name;

  @override
  int compareTo(covariant Tab other) => index.compareTo(other.index);

  @override
  int get hashCode => index;

  @override
  bool operator ==(dynamic other) => other is Tab && index == other.index;

  @override
  String toString() => name;
}
