import 'dart:math';

import 'package:custom_expansion_tile/examples/body.dart';
import 'package:custom_expansion_tile/expansionWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WithCustomTrailingAnimation extends StatelessWidget {
  const WithCustomTrailingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom trailing animation"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Bigger animation'),
          ExpansionWidget(
            activeIconColor: Colors.red,
            disabledIconColor: Colors.blue,
            trailingIconAnimationBuilder: (context, trailingIcon, value) {
              return Transform.rotate(
                angle: value * pi,
                child: Transform.scale(
                  scale: value + 1,
                  child: trailingIcon,
                ),
              );
            },
            primary: Text('This is the title'),
            child: Body(),
          ),
          Text('Disappearing animation'),
          ExpansionWidget(
            trailing: Icon(Icons.opacity),
            trailingIconAnimationBuilder: (context, trailingIcon, value) {
              return Opacity(
                opacity: (value - 1).abs(),
                child: trailingIcon,
              );
            },
            primary: Text('This is the title'),
            child: Body(),
          ),
        ],
      ),
    );
  }
}
