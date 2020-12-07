import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';
import 'settings.dart';

void main() {
  Paint.enableDithering = true;
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Hot Takes',
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey,
      ),
      home: new Dashboard(title: 'Hot Takes'),
      routes: {
        'settings': (_) => Settings(),
        'leagues': (_) => Settings(),
        'password': (_) => Settings(),
        'premium': (_) => Settings(),
        'email': (_) => Settings(),
        'delivery': (_) => Settings(),
      },
    );
  }
}
