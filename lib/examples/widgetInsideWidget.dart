import 'package:custom_expansion_tile/examples/body.dart';
import 'package:custom_expansion_tile/expansionWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ExpansionInsideExpansion extends StatelessWidget {
  const ExpansionInsideExpansion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expansion inside expansion'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ExpansionWidget(
            primary: Text('This is the title'),
            child: Column(
              children: [
                Body(),
                Container(
                  width: 300,
                  child: ExpansionWidget(
                    isIconOnTheRight: false,
                    primary: Text('This expansion is inside'),
                    child: Body(),
                    dividerBuilder: (context, isUpperDivider) {
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
