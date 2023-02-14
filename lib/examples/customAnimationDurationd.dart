import 'package:custom_expansion_tile/examples/body.dart';
import 'package:custom_expansion_tile/expansionWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomAnimationDuration extends StatelessWidget {
  const CustomAnimationDuration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Duration"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ExpansionWidget(
            expandingAnimationDuration: Duration(seconds: 4),
            primary: Text('This is the title'),
            child: Body(),
          ),
        ],
      ),
    );
  }
}
