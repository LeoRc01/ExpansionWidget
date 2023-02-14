import 'package:custom_expansion_tile/examples/body.dart';
import 'package:custom_expansion_tile/expansionWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ExpansionWithCustomColors extends StatelessWidget {
  const ExpansionWithCustomColors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expansion with custom colors"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: ExpansionWidget(
              backgroundColor: Colors.red,
              collapsedBackgroundColor: Colors.blue,
              primary: Text("This is the title"),
              child: Body(),
            ),
          ),
        ],
      ),
    );
  }
}
