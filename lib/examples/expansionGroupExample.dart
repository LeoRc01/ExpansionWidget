import 'package:custom_expansion_tile/expansionWidget.dart';
import 'package:custom_expansion_tile/examples/body.dart';
import 'package:custom_expansion_tile/expansionGroup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ExpansionGroupExample extends StatefulWidget {
  const ExpansionGroupExample({super.key});

  @override
  State<ExpansionGroupExample> createState() => _ExpansionGroupExampleState();
}

class _ExpansionGroupExampleState extends State<ExpansionGroupExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expansion Group'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ExpansionGroup.buidler(
          builder: (groupContext) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ExpansionWidget(
                key: ValueKey(1),
                primary: Text('this is the title of the first widget'),
                child: Body(),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red.withOpacity(.1),
                ),
                child: ExpansionWidget(
                  borderRadius: BorderRadius.circular(20),
                  dividerBuilder: (context, isUpperDivider) {
                    return Container();
                  },
                  key: const ValueKey(2),
                  primary: const Text('this is the title of the second widget'),
                  child: const Body(),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    ExpansionInheritedWidget.of(groupContext)
                        .closeCurrentlyOpenedWidget();
                  },
                  child: const Text('CLOSE CURRENTLY OPENED WIDGET'))
            ],
          ),
        ),
      ),
    );
  }
}
