import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/services/auth.dart';
import 'login.dart';
import 'settings.dart';
import 'screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Paint.enableDithering = true;
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
        value: AuthService().user,
        child: CupertinoApp(
            home: Wrapper(),
            theme: CupertinoThemeData(brightness: Brightness.dark)));
  }
}

/*class App extends StatelessWidget {
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
}*/
