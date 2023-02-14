import 'package:custom_expansion_tile/expansionWidget.dart';
import 'package:flutter/material.dart';

/// Handles a group of ExpansionWidgets.
///
/// Wrap your list of ExpansionWidgets if you want an automatically close behaviour
/// when you open one Widget.
class ExpansionGroup extends StatefulWidget {
  ExpansionGroup({
    super.key,
    required Widget child,
  }) : builder = ((BuildContext context) => child);

  const ExpansionGroup.buidler({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context) builder;

  @override
  State<ExpansionGroup> createState() => _ExpansionGroupState();
}

class _ExpansionGroupState extends State<ExpansionGroup> {
  Key? _currentlyOpenedWidgetKey;
  bool allClosed = false;

  void setNewCurrentlyOpenedWidgetKey(Key? newOpenedWidgetKey) {
    setState(() {
      _currentlyOpenedWidgetKey = newOpenedWidgetKey;
    });
  }

  void _closeCurrentlyOpenedWidget() {
    setState(() {
      _currentlyOpenedWidgetKey = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionInheritedWidget(
      onStateChanged: setNewCurrentlyOpenedWidgetKey,
      openedWidgetKey: _currentlyOpenedWidgetKey,
      closeCurrentlyOpenedWidget: _closeCurrentlyOpenedWidget,
      child: ExpansionBuilder(builder: widget.builder),
    );
  }
}

class ExpansionBuilder extends StatelessWidget {
  const ExpansionBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return builder.call(context);
  }
}
