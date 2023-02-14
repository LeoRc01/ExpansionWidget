import 'package:custom_expansion_tile/expansionWidget.dart';
import 'package:flutter/material.dart';

class ExpansionKey extends LocalKey {
  final ExpansionWidget child;

  const ExpansionKey(this.child);

  void open() {
    child;
  }

  void close() {}
}
