import 'package:flutter/material.dart';
//import 'package:taxirev/customecolors/palete.dart';
import 'screens/dashboard.dart';
import 'customecolors/palete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eREV 1.0',
      theme: ThemeData(
          //primarySwatch: Palette.kToDark, bottomAppBarColor: Palette.kToDark),
          primarySwatch: Palette.kToDark,
          bottomAppBarColor: Palette.kToDark),
      home: const Dashboard(),
    );
  }
}
