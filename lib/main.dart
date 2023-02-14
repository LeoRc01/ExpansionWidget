import 'package:custom_expansion_tile/mainPage.dart';
import 'package:custom_expansion_tile/provider/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(currentTheme: ThemeMode.dark),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: context.watch<ThemeProvider>().currentTheme,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(brightness: Brightness.dark),
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
