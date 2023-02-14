import 'package:custom_expansion_tile/examples/body.dart';
import 'package:custom_expansion_tile/expansionWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ExpandedWidgetWithCustomDivider extends StatelessWidget {
  const ExpandedWidgetWithCustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Divider'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("CUSTOM DIVIDER"),
            ExpansionWidget(
              dividerBuilder: (context, isUpperDivider) {
                return Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(isUpperDivider ? 10 : 0),
                      topLeft: Radius.circular(isUpperDivider ? 10 : 0),
                      bottomLeft: Radius.circular(!isUpperDivider ? 10 : 0),
                      bottomRight: Radius.circular(!isUpperDivider ? 10 : 0),
                    ),
                  ),
                );
              },
              primary: const Text("This is the title of the widget"),
              child: const Body(),
            ),
            const SizedBox(
              height: 100,
            ),
            const Text("NO DIVIDER"),
            ExpansionWidget(
              dividerBuilder: (context, isUpperDivider) {
                return Container();
              },
              primary: const Text("This is the title of the widget"),
              child: const Body(),
            ),
          ],
        ),
      ),
    );
  }
}
