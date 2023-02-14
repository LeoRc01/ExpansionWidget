import 'package:custom_expansion_tile/examples/colors.dart';
import 'package:custom_expansion_tile/examples/customAnimationDurationd.dart';
import 'package:custom_expansion_tile/expansionWidget.dart';
import 'package:custom_expansion_tile/examples/customTrailingAnimation.dart';
import 'package:custom_expansion_tile/examples/expansionGroupExample.dart';
import 'package:custom_expansion_tile/examples/listView.dart';
import 'package:custom_expansion_tile/provider/themeProvider.dart';
import 'package:custom_expansion_tile/examples/widgetInsideWidget.dart';
import 'package:custom_expansion_tile/examples/withCustomDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (context.read<ThemeProvider>().currentTheme ==
                    ThemeMode.dark) {
                  context.read<ThemeProvider>().setTheme(ThemeMode.light);
                } else {
                  context.read<ThemeProvider>().setTheme(ThemeMode.dark);
                }
              },
              icon:
                  context.watch<ThemeProvider>().currentTheme == ThemeMode.dark
                      ? Icon(Icons.light_mode)
                      : Icon(Icons.dark_mode)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Expansion Widget Use cases"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ListViewWithExpansionWidget()));
              },
              child: Text("ListView with Expansion Widget"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ExpansionWithCustomColors()));
              },
              child: Text("Expansion Widget with custom Colors"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => CustomAnimationDuration()));
              },
              child: Text("Expansion widget with custom animation duration"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ExpandedWidgetWithCustomDivider()));
              },
              child: Text("Expansion widget with custom divider"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => WithCustomTrailingAnimation()));
              },
              child: Text("Expansion widget with custom trailing animation"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ExpansionInsideExpansion()));
              },
              child: Text("Expansion widget inside expansion widget"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ExpansionGroupExample()));
              },
              child: Text("Expansion group"),
            ),
          ],
        ),
      ),
    );
  }
}
