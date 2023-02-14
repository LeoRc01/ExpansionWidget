import 'package:custom_expansion_tile/examples/body.dart';
import 'package:custom_expansion_tile/expansionGroup.dart';
import 'package:custom_expansion_tile/expansionWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ListViewWithExpansionWidget extends StatelessWidget {
  const ListViewWithExpansionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text("ListView with Expansion Widget"),
      ),
      body: ExpansionGroup(
        child: ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) {
            return ExpansionWidget(
                key: ValueKey(index),
                primary:
                    Text("This is the title of the ${index.toString()} widget"),
                child: const Body());
          },
        ),
      ),
    );
  }
}
